require 'spec_helper'

describe Hideable::ActiveRecord::InstanceMethods do

  let(:datetime) { DateTime.new(2022,10,10,10,10,10,'+0') }

  describe '#hidden?' do
    it 'when hidden_at is set' do
      user = User.new(:hidden_at => datetime)
      user.hidden?.should be_true
    end
    it 'when hidden_at is nil' do
      user = User.new
      user.hidden?.should be_false
    end
  end

  describe '#hide!' do
    it 'sets hidden_at' do
      user = User.new
      Timecop.freeze(datetime) do
        user.hide!
      end
      user.hidden_at.should eql datetime
    end
    it 'sets hidden_at for has_one dependent' do
      user = User.new
      user.build_user_history
      Timecop.freeze(datetime) do
        user.hide!
      end
      user.user_history.hidden_at.should eql datetime
    end
    it 'sets hidden_at for has_many dependent' do
      user = User.new
      user.posts.build
      user.posts.first.attachments.build
      Timecop.freeze(datetime) do
        user.hide!
      end
      user.posts.first.hidden_at.should eql datetime
      user.posts.first.attachments.first.hidden_at.should eql datetime
    end
    it 'sets hidden_at for has_one through dependent' do
      user = User.new
      user.build_user_history
      user.user_history.build_address
      Timecop.freeze(datetime) do
        user.hide!
      end
      user.user_history.hidden_at.should eql datetime
      user.address.hidden_at.should be_nil
    end
    it 'sets hidden_at for has_many through dependent' do
      post = Post.new
      post.tags.build
      Timecop.freeze(datetime) do
        post.hide!
      end
      post.taggings.first.hidden_at.should eql datetime
      post.tags.first.hidden_at.should be_nil
    end
    it 'sets hidden_at for has_and_belongs_to_many dependent' do
      post = Post.new
      post.photos.build
      Timecop.freeze(datetime) do
        post.hide!
      end
      post.photos.first.hidden_at.should eql datetime
    end
  end

  describe '#unhide!' do
    it 'sets hidden_at to nil' do
      user = User.new(:hidden_at => datetime)
      user.unhide!
      user.hidden_at.should be_nil
    end
  end

end
