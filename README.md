# Hideable

[![Build Status](https://secure.travis-ci.org/joecorcoran/hideable.png?branch=master)](http://travis-ci.org/joecorcoran/hideable)

A simple way to provide hideability to ActiveRecord models. Mark records as hidden instead of destroying them for good.

## Use

Run the generator to create migrations for all of the models you want to hide:

    $ rails generate hideable:migration Foo Bar
    $ rake db:migrate
    
Declare your models `hideable`:
 
    class Foo < ActiveRecord::Base
      extend Hideable::ActiveRecord
      hideable
    end
    
This will add `hide!`, `unhide!` and `hidden?` instance methods and `hidden` and `not_hidden` scopes.
    
Hideable is designed to work in a similar way to the `:dependent` option on associations too, if that's what you want.

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

All models that you wish to hide, including dependents, must be declared as `hideable`.

    > foo = Foo.not_hidden.first
    > foo.hide
    > foo.bar.hidden? #=> true

## Why?

Knowing that you can hide or unhide a record is often better destroying it for good. Other gems – such as [paranoia](https://github.com/radar/paranoia) and [acts_as_paranoid](https://github.com/technoweenie/acts_as_paranoid) – do a similar job by overriding `#destroy`, which I don't like.

## Development

Install the general dependencies, including all the versions of `activerecord` that `hideable` is tested against.

```
$ bundle install && rake appraisal:install
```

Run tests as follows.

```
$ rake appraisal
```
