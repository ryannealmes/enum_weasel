require 'enum_weasel'

namespace :enum_weasel do
  task :generate_enum_tables do
    EnumWeasel::Generator.new.call
  end
end