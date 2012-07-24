module Hideable

  module Scope

    def hidden
      where(self.arel_table[:hidden_at].not_eq(nil))
    end

    def visible
      where(self.arel_table[:hidden_at].eq(nil))
    end

  end

end