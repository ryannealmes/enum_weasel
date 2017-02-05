module EnumWeasel
  # Handles all configuration settings required
  # to interaction with a Moodle API
  class Configuration
    attr_accessor :prefix

    DEFAULT_PREFIX = 'enum_weasel'

    def initialize(options = {})
      @prefix = DEFAULT_PREFIX

      configure(options)
    end

    def reset
      @prefix = DEFAULT_PREFIX
    end

    def configure(options = {}, &block)
      options.each do |key, value| 
        instance_variable_set("@#{key}", value) 
        fail ArgumentError.new "The configuration key [#{key}] cannot be blank"
      end
      block.call(self) if block_given?
    end
  end
end
