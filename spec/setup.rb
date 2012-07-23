ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
ActiveRecord::Schema.define(:version => 1) do
  create_table :users do |t|
    t.datetime :hidden_at
  end
  create_table :user_histories do |t|
    t.datetime :hidden_at
    t.integer :user_id
  end
  create_table :addresses do |t|
    t.datetime :hidden_at
    t.integer :user_history_id
  end
  create_table :posts do |t|
    t.datetime :hidden_at
    t.integer  :user_id
  end
  create_table :attachments do |t|
    t.datetime :hidden_at
    t.integer  :post_id
  end
  create_table :likes do |t|
    t.integer :post_id
  end
  create_table :taggings do |t|
    t.datetime :hidden_at
    t.integer :post_id
    t.integer :tag_id
  end
  create_table :tags do |t|
    t.datetime :hidden_at
  end
  create_table :mistakes
  create_table :photos do |t|
    t.datetime :hidden_at
  end
  create_table :photos_posts, :id => false do |t|
    t.integer :photo_id
    t.integer :post_id
  end
end

class User < ActiveRecord::Base
  hideable :dependent => :hide
  has_many :posts
  has_one :user_history
  has_one :address, :through => :user_history
end

class UserHistory <  ActiveRecord::Base
  hideable
  belongs_to :user
  has_one :address
end

class Address < ActiveRecord::Base
  hideable
  belongs_to :user_history
  belongs_to :user
end

class Post < ActiveRecord::Base
  hideable :dependent => :hide
  belongs_to :user
  has_many :attachments
  has_many :likes
  has_many :taggings
  has_many :tags, :through => :taggings
  has_and_belongs_to_many :photos
end

class Attachment < ActiveRecord::Base
  hideable
  belongs_to :post
end

class Like < ActiveRecord::Base
  belongs_to :post
end

class Tag < ActiveRecord::Base
  hideable
  has_many :taggings
  has_many :posts, :through => :taggings
end

class Tagging < ActiveRecord::Base
  hideable
  belongs_to :post
  belongs_to :tag
end

class Photo < ActiveRecord::Base
  hideable
  has_and_belongs_to_many :posts
end

class Mistake < ActiveRecord::Base
  hideable
end
