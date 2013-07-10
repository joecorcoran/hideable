module Hideable
  module Generators
    
    class MigrationGenerator < Rails::Generators::Base
      desc 'Generates a hideable migration for each given class.'
      argument :classes, :type => :array, :default => [], :banner => 'User Post'
      def exec
        classes.each do |c|
          table_name = c.constantize.table_name
          generate('migration', "AddHiddenAtTo#{table_name.camelize} hidden_at:datetime")
        end
      end
    end

  end
end
