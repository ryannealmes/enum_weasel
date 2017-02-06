module EnumWeasel
  class Generator
    module Tables
      class Creation
        attr_reader :source_enum_tables, :database_enum_tables

        def initialize(source_enum_tables, database_enum_tables)
          @source_enum_tables = source_enum_tables
          @database_enum_tables = database_enum_tables
        end

        def call
          new_enum_tables.each_key do |enum_table_name|
            creat_table enum_table_name.to_sym
          end
        end

        def creat_table table_name
          unless connection.table_exists?(table_name)

            connection.create_table table_name do |t|
              t.integer :name, null: false
              t.string :value, null: false
            end

            connection.add_index table_name, 'name', unique: true, name: "#{table_name}_index"
          end
        end

        def new_enum_tables
          source_enum_tables.except!(*database_enum_tables)
        end

        def connection
          ActiveRecord::Base.connection
        end
      end
    end
  end
end
