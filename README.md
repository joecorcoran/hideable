# Hideable

[![Build Status](https://secure.travis-ci.org/joecorcoran/hideable.png?branch=master)](http://travis-ci.org/joecorcoran/hideable)

Not yet released.

A simple way to provide hideability to ActiveRecord models. Mark records as hidden instead of destroying them for good.

## Use

Run the generator to create migrations for all of the models you want to hide:

    $ rails generate hideable:migration Foo Bar
    $ rake db:migrate
    
Declare your models `hideable`:
 
    class Foo < ActiveRecord::Base
      hideable
    end
    
This will add `hide`, `show`, `hidden?` and `visible?` instance methods and `hidden` and `visible` class methods.
    
Hideable is designed to work in a similar way to the `:dependent` option on associations too, if that's what you want.

    class Foo < ActiveRecord::Base
      has_one :bar
      hideable :dependent => :hide
    end
    
    class Bar < ActiveRecord::Base
      belongs_to :foo
      hideable
    end

All models that you wish to hide, including dependents, must be declared as `hideable`.

    > foo = Foo.visible.first
    > foo.hide
    > foo.bar.hidden? #=> true

## Why?

If you're scared of destroying user generated content. Knowing that you can hide or show a record is sometimes nicer than a permanent delete/destroy.