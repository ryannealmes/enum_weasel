module EnumWeasel
  class Generators
    module Tables
      class Deletion < Migration
        def enum_tables
          database_enum_tables - formatted_model_enum_names
        end

        def run_migration table
          if connection.table_exists? table
            connection.drop_table table 
          end
        end
      end
    end
  end
end
