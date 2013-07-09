module Hideable

  module Core

    MACROS = [:has_many, :has_one, :has_and_belongs_to_many]

    def hidden?
      self.hidden_at.is_a?(DateTime)
    end

    def visible?
      !self.hidden?
    end

    def accept?(method)
      method == :hide! ? visible? : hidden?
    end

    def hide!
      update_hideable_record
    end

    def unhide!
      update_hideable_record(:method => :unhide!)
    end

    private

      def update_hideable_record(options = {})
        options = { :method => :hide! }.merge(options)
        return unless self.accept?(options[:method])
        self.hidden_at = (options[:method] == :unhide!) ? nil : DateTime.now
        self.save!
      end

      def update_hideable_dependent
      def update_hideable_dependents
        self.class.reflect_on_all_associations.each do |reflection|
          if MACROS.include?(reflection.macro) && reflection.options[:through].nil? && self.class.hideable_dependent == true
            dependent_records = Array(self.send(reflection.name)).compact
            dependent_records.each do |record|
              method = self.hidden? ? :hide! : :unhide!
              record.send(method) if record.respond_to?(method)
            end
          end
        end
      end

  end

end
