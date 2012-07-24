module Hideable

  module ActiveRecord

    def hideable(options = {})
      extend Hideable::Scope
      include Hideable::Core
      options = { :dependent => nil }.merge(options)
      class_attribute :hideable_dependent
      self.hideable_dependent = (options[:dependent] == :hide) ? true : false
      after_save :update_hideable_dependent
    end

  end

end

::ActiveRecord::Base.extend Hideable::ActiveRecord