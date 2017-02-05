module EnumWeasel
  class Generator
    def call
      puts ::ActiveRecord::Base.connection.table_exists?("weasel")
      return "pong"
    end
  end
end
