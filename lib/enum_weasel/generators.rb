module EnumWeasel
  # Acts a coordinator to keep enums tables and related data in sync
  class Generators
    attr_writer :table_creation,
                :table_deletion,
                :data_creation,
                :data_deletion

    def call
      create_new_enum_tables
      delete_old_enum_tables
      update_enum_table_data
    end

    private

    def create_new_enum_tables
      table_creation.call
    end

    def delete_old_enum_tables
      table_deletion.call
    end

    def update_enum_table_data
      data_creation.call
      data_deletion.call
    end

    def table_creation
      @table_creation ||= Tables::Creation.new(model_enums,
                                               existing_enum_tables)
    end

    def table_deletion
      @table_deletion ||= Tables::Deletion.new(model_enums,
                                               existing_enum_tables)
    end

    def data_creation
      @data_creation ||= Data::Creation.new(model_enums,
                                            existing_enum_tables)
    end

    def data_deletion
      @data_deletion ||= Data::Deletion.new(model_enums,
                                            existing_enum_tables)
    end

    def model_enums
      @model_enums ||= GetModelEnums.new.call
    end

    def existing_enum_tables
      @existing_enum_tables ||= ActiveRecord::Base.connection
                                                  .tables
                                                  .select{ |key| key.to_s.match(/^enum/) }
    end
  end
end
