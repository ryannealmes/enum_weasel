module EnumWeasel
  class Generator
    attr_writer :configuration

    def initialize(options = {})
      configure(options)
    end

    def call
      return "pong"
    end

    def create_enum_tables
      EnumWeasel::Creation.new.call model_enums, existing_tables
    end

    def model_enums
      @model_enums ||= EnumWeasel::GetModelEnums.new.call
    end

    def existing_tables
      @existing_tables ||= ActiveRecord::Base.connection.tables.select { |key, value| key.to_s.match(/^enum/) }
    end

    def to_be_deleted_enum_tables
      # needs to be coded
      # existing_tables.except!(*model_enums.keys)
    end

    def configure(options = {}, &block)
      configuration.configure(options, &block)
    end

    def reset_configuration
      configuration.reset
    end

    def configuration
      @configuration ||= Configuration.new
    end
  end
end
