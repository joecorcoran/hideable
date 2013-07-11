require 'spec_helper'

describe Hideable::ActiveRecord do

  let(:hidden_post) { Post.create(:hidden_at => DateTime.new(2022,10,10,10,10,10,'+0')) }
  let(:visible_post) { Post.create }
  
  describe '.hideable' do
    it 'adds instance methods to class when called' do
      Attachment.included_modules.should include Hideable::ActiveRecord::InstanceMethods
    end
    it 'adds class methods to class when called' do
      methods = [:hideable, :hidden, :not_hidden]
      methods.all? { |m| Attachment.methods.include?(m) }.should be_true
    end
    it 'adds hide_dependent class_attribute with correct value when hideable macro is used' do
      Post.hide_dependents.should be_true
      Attachment.hide_dependents.should be_false
      Like.should_not respond_to :hide_dependents
    end
  end

  specify '.hidden' do
    Post.hidden.should include hidden_post
    Post.hidden.should_not include visible_post
  end

  specify '.not_hidden' do
    Post.not_hidden.should include visible_post
    Post.not_hidden.should_not include hidden_post
  end
  
end
