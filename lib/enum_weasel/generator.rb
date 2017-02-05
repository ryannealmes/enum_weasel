module EnumWeasel
  class Generator
    attr_writer :configuration
    
    def initialize(options = {})
      configure(options)
    end

    def call
      puts ::ActiveRecord::Base.connection.table_exists?("weasel")
      return "pong"
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
