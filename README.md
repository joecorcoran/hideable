# Hideable

Not yet released.

A simple way to provide hideability to ActiveRecord models. Mark records as hidden instead of destroying them for good.

## Use

This will add `hide`, `show`, `hidden?` and `visible?` instance methods to your model.

    class Foo < ActiveRecord::Base
      hideable
    end
    
Hideable is designed to work in the same way as the `:dependent => :destroy` options on associations too, if that's what you want.

    class Foo < ActiveRecord::Base
      hideable :dependent => :hide
    end

## Why?

If you're scared of destroying user generated content. Knowing that you can undo an accidental destroy is nice.