module EnumWeasel
  class Generators
    module Tables
      class Migration
        attr_reader :model_enums, 
          :database_enum_tables, 
          :connection

        def initialize(model_enums, database_enum_tables)
          @model_enums = model_enums
          @database_enum_tables = database_enum_tables
          @connection = ActiveRecord::Base.connection
        end

        def call
          enum_tables.each do |table|
            run_migration table
          end
        end
        
        def enum_tables
          fail NotImplementedError
        end

        def run_migration table
          fail NotImplementedError
        end

        def formatted_model_enum_names
          formatted_names = []
          
          model_enums.each_key do |model_name|
            model_enums[model_name].each do |enum|
              pluralized_table_name = ActiveSupport::Inflector.pluralize(model_name, :en)
              formatted_names << "#{pluralized_table_name}_#{enum}_enum"
            end
          end

          formatted_names
        end
      end
    end
  end
end
