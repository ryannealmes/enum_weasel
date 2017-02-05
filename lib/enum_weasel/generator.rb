module EnumWeasel
  class Generator

    def call
      return "pong"
    end

    def model_enums
      @model_enums ||= EnumWeasel::GetModelEnums.new.call
    end

    def existing_tables
      @existing_tables ||= ActiveRecord::Base.connection.tables.select { |key, value| key.to_s.match(/^enum/) }
    end

    def new_enum_tables
      model_enums.except!(*existing_tables)
    end

    def to_be_deleted_enum_tables
      existing_tables.except!(*model_enums.keys)
    end
  end
end
