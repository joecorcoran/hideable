# Hideable

[![Build Status](https://secure.travis-ci.org/joecorcoran/hideable.png?branch=master)](http://travis-ci.org/joecorcoran/hideable)

A simple way to provide hideability to ActiveRecord models. Mark records as hidden instead of destroying them for good.

## Usage

### Setup

Run the generator to create migrations for all of the models you want to hide:

```bash
rails generate hideable:migration Foo Bar
rake db:migrate
```
    
Make your models `hideable`:
 
```ruby
class Foo < ActiveRecord::Base
  extend Hideable::ActiveRecord
  hideable
end
```
    
This will add `#hide!`, `#unhide!` and `#hidden?` instance methods and `.hidden` and `.not_hidden` scopes.

### Associations
    
Hideable is designed to work in a similar way to the `:dependent` option on associations too, if that's what you want.

```ruby
class Foo < ActiveRecord::Base
  has_one :bar

  extend Hideable::ActiveRecord
  hideable :dependent => :hide
end
    
class Bar < ActiveRecord::Base
  belongs_to :foo
      
  extend Hideable::ActiveRecord
  hideable
end
```

All models that you wish to hide, including dependents, must be declared as `hideable`.

```ruby
foo = Foo.not_hidden.first
foo.hide!
foo.bar.hidden? #=> true
```

Hiding dependents requires the records to be instantiated and can be quite expensive depending on the number of records. You can move the operation into the background where suitable. Instead of `:dependent => :hide`, use the `:updated` option to provide a method name or callable that will be called when the object is hidden or unhidden. The following example demonstrates the use of [Sidekiq](http://github.com/mperham/sidekiq) to hide dependents asynchronously.

```ruby
class Foo < ActiveRecord::Base
  has_one :bar

  extend Hideable::ActiveRecord
  hideable :updated => :update_bars

  private
    def update_bars
      HideableWorker.perform_async(self.class.name, self.id)
    end
end
    
class Bar < ActiveRecord::Base
  belongs_to :foo
      
  extend Hideable::ActiveRecord
  hideable
end

require 'sidekiq'
class HideableWorker
  include Sidekiq::Worker

  def perform(klass_name, id)
    klass = klass_name.constantize
    klass.find(id).update_hideable_dependencies!
  end
end
```

## Why?

Knowing that you can hide or unhide a record is often better destroying it for good. Other gems – such as [paranoia](https://github.com/radar/paranoia) and [acts_as_paranoid](https://github.com/technoweenie/acts_as_paranoid) – do a similar job by overriding `#destroy`, which I don't like.

## Development

Install the general dependencies, including all the versions of `activerecord` that `hideable` is tested against.

```bash
bundle install && rake appraisal:install
```

Run tests as follows.

```bash
rake appraisal
```
