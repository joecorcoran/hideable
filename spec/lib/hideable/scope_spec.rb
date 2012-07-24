require 'spec_helper'

describe Hideable::Scope do
  let(:datetime) { DateTime.new(2022,10,10,10,10,10,'+0') }
  let(:hidden_post) { Post.create(:hidden_at => datetime) }
  let(:visible_post) { Post.create }

  specify "hidden" do
    Post.hidden.should include hidden_post
    Post.hidden.should_not include visible_post
  end
  specify "visible" do
    Post.visible.should include visible_post
    Post.visible.should_not include hidden_post
  end
end