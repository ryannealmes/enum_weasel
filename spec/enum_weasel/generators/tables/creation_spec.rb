require 'spec_helper'

describe EnumWeasel::Generators::Tables::Creation do  
  before do
    ActiveRecord::Base.establish_connection(adapter: 'sqlite3',
                                            database: ':memory:')
  end

  it "creates a single enum reference table" do
    model_enums = { "weasel" => ["status"] }

    EnumWeasel::Generators::Tables::Creation.new(model_enums, []).call
    
    reference_table_exists = ActiveRecord::Base.connection.tables.select { |key, value| key.to_s == "weasels_status_enum" }.any?
    expect(reference_table_exists).to be true
  end

  it "creates multiple enum reference tables for a single model" do
    model_enums = { "weasel" => ["status", "mood"] }

    EnumWeasel::Generators::Tables::Creation.new(model_enums, []).call
    
    reference_tables = ActiveRecord::Base.connection.tables.select { |key, value| key =~ /_enum/ }
    expect(reference_tables).to match_array ["weasels_status_enum", "weasels_mood_enum"]
  end

  it "creates multiple enum reference tables for multiple models" do
    model_enums = {
      "weasel" => ["status", "mood"],
      "panda" => ["hunger_level"]
    }

    EnumWeasel::Generators::Tables::Creation.new(model_enums, []).call
    
    reference_tables = ActiveRecord::Base.connection.tables.select { |key, value| key =~ /_enum/ }
    expect(reference_tables).to match_array ["weasels_status_enum", "weasels_mood_enum", "pandas_hunger_level_enum"]
  end

  it "does not create duplicate tables" do
    model_enums = { "weasel" => ["status"] }

    EnumWeasel::Generators::Tables::Creation.new(model_enums, []).call
    EnumWeasel::Generators::Tables::Creation.new(model_enums, []).call
    
    reference_table_exists = ActiveRecord::Base.connection.tables.select { |key, value| key.to_s == "weasels_status_enum" }.any?

    expect(reference_table_exists).to be true
  end
end
