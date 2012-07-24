require 'spec_helper'

describe Hideable::ActiveRecord do

  before(:all) do
    class Post < ActiveRecord::Base
      hideable :dependent => :hide
    end
    class Attachment < ActiveRecord::Base
      hideable
    end
    class Like < ActiveRecord::Base; end
  end
  
  describe "hideable class macro" do
    it "is available to classes that inherit from ActiveRecord" do
      Like.methods.should include :hideable
    end
    it "adds instance methods to class when called" do
      Attachment.included_modules.should include Hideable::Core
    end
    it "adds class methods to class when called" do
      Attachment.singleton_class.included_modules.should include Hideable::Scope
    end
    it "adds hide_dependent class_attribute with correct value when hideable macro is used" do
      Post.hideable_dependent.should be_true
      Attachment.hideable_dependent.should be_false
      Like.should_not respond_to :hideable_dependent
    end
  end
  
end