module Hideable
  module ActiveRecord

    def hideable(options = {})
      send :include, InstanceMethods
      class_attribute :hide_dependent
      self.hide_dependent = options[:dependent] == :hide ? true : false
      after_save :update_hideable_dependents
    end

    def hidden
      where(self.arel_table[:hidden_at].not_eq(nil))
    end

    def visible
      where(self.arel_table[:hidden_at].eq(nil))
    end

  end
end
