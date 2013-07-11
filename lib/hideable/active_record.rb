module Hideable
  module ActiveRecord

    def hideable(options = {})
      send :include, InstanceMethods
      class_attribute :hide_dependents
      self.hide_dependents = options[:dependent] == :hide ? true : false
      after_save :update_hideable_dependents!, :if => :update_hideable_dependents?
    end

    def hidden
      where(self.arel_table[:hidden_at].not_eq(nil))
    end

    def not_hidden
      where(self.arel_table[:hidden_at].eq(nil))
    end

  end
end
