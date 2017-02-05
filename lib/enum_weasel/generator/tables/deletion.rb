module EnumWeasel
  class Generator
    module Tables
      class Deletion
        attr_reader :source_enum_tables, database_enum_tables

        def initialize(source_enum_tables, database_enum_tables)
          @source_enum_tables = source_enum_tables
          @database_enum_tables = database_enum_tables
        end

        def call
          enums_to_delete = database_enum_tables - source_enum_tables 
          enums_to_delete.each { |table_name| delete_table table_name }
        end

        def delete_table table
          if connection.table_exists?(table_name)
            connection.drop table table_name
          end
        end

        def connection
          ActiveRecord::Base.connection
        end
      end
    end
  end
end