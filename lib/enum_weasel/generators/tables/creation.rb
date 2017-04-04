module EnumWeasel
  class Generators
    module Tables
      # Handles the creation of new enum tables
      class Creation < Migration
        def enum_tables
          formatted_model_enum_names - database_enum_tables
        end

        def run_migration(table)
          return if connection.table_exists? table
          connection.create_table table do |t|
            t.integer :name, null: false
            t.string :value, null: false
          end
        end
      end
    end
  end
end
