require 'spec_helper'

describe Hideable::ActiveRecord do

  let(:hidden_post) { Post.create(:hidden_at => DateTime.new(2022,10,10,10,10,10,'+0')) }
  let(:visible_post) { Post.create }

  before(:all) do
    class Like < ActiveRecord::Base; end
  end
  
  describe ".hideable" do
    it "adds instance methods to class when called" do
      Attachment.included_modules.should include Hideable::ActiveRecord::InstanceMethods
    end
    it "adds class methods to class when called" do
      [:hideable, :hidden, :visible].all? { |m| Attachment.methods.include?(m) }
    end
    it "adds hide_dependent class_attribute with correct value when hideable macro is used" do
      Post.hide_dependent.should be_true
      Attachment.hide_dependent.should be_false
      Like.should_not respond_to :hide_dependent
    end
  end

  specify ".hidden" do
    Post.hidden.should include hidden_post
    Post.hidden.should_not include visible_post
  end

  specify ".visible" do
    Post.visible.should include visible_post
    Post.visible.should_not include hidden_post
  end
  
end
