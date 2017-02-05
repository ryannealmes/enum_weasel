module EnumWeasel
  class CreateEnumTable
    attr_reader :table_name, :enum

    def call table_name, enum
      @table_name = table_name
      @enum = enum

      generate_table
    end

    def generate_table
      unless connection.table_exists?(table_name.to_sym)
        connection.create_table table_name.to_sym do |t|
          t.integer enum, null: false
          t.string :value, null: false
        end

        connection.add_index table_name, enum, unique: true, name: "#{table_name}_index"
      end
    end

    def connection
      ActiveRecord::Base.connection
    end
  end
end
