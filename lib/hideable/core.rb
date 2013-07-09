module Hideable

  module Core

    MACROS = [:has_many, :has_one, :has_and_belongs_to_many]

    def hidden?
      self.hidden_at.is_a?(DateTime)
    end

    def hide!
      return if self.hidden?
      self.hidden_at = DateTime.now
      self.save!
    end

    def unhide!
      return unless self.hidden?
      self.hidden_at = nil
      self.save!
    end

    private

      def update_hideable_dependents
        self.class.reflect_on_all_associations.each do |reflection|
          if MACROS.include?(reflection.macro) && reflection.options[:through].nil? && self.class.hideable_dependent == true
            dependent_records = Array(self.send(reflection.name)).compact
            dependent_records.each do |record|
              action = self.hidden? ? :hide! : :unhide!
              record.send(action) if record.respond_to?(action)
            end
          end
        end
      end

  end

end
