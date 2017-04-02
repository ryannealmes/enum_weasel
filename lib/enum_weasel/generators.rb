module EnumWeasel
  class Generators
    # def call
    #   create_new_enum_tables
    #   delete_old_enum_tables
    #   update_enum_table_data
    # end

    # def create_new_enum_tables
    #   # EnumWeasel::Generator::Tables::Creation.new(model_enums, existing_enum_tables).call 
    # end

    # def delete_old_enum_tables
    #   # EnumWeasel::Generator::Tables::Deletion.new(model_enums, existing_enum_tables).call 
    # end

    # def update_enum_table_data
    #   # EnumWeasel::Generator::Data::Creation.new(model_enums, existing_enum_tables).call 
    #   # EnumWeasel::Generator::Data::Deletion.new(model_enums, existing_enum_tables).call 
    #   # EnumWeasel::Generator::Data::Update.new(model_enums, existing_enum_tables).call 
    # end

    # def model_enums
    #   @model_enums ||= EnumWeasel::GetModelEnums.new.call
    # end

    # def existing_enum_tables
    #   @existing_enum_tables ||= ActiveRecord::Base.connection.tables.select { |key, value| key.to_s.match(/^enum/) }
    # end
  end
end
