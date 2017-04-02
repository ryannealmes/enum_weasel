require 'spec_helper'

describe EnumWeasel::Generators::Tables::Deletion do  
  before do
    ActiveRecord::Base.establish_connection(adapter: 'sqlite3',
                                            database: ':memory:')
  end

  it "deletes a single enum reference table" do
    ActiveRecord::Base.connection.create_table :weasels_status_enum do |t|; end

    EnumWeasel::Generators::Tables::Deletion.new({}, ["weasels_status_enum"]).call

    expect(ActiveRecord::Base.connection.tables.any?).to be false
  end

  it "deletes multiple enum reference tables" do
    ActiveRecord::Base.connection.create_table :weasels_status_enum do |t|; end
    ActiveRecord::Base.connection.create_table :weasels_mood_enum do |t|; end

    EnumWeasel::Generators::Tables::Deletion.new({}, ["weasels_status_enum", "weasels_mood_enum"]).call
    
    expect(ActiveRecord::Base.connection.tables.any?).to be false
  end

  it "does not delete incorrect enum reference tables" do
    ActiveRecord::Base.connection.create_table :weasels_status_enum do |t|; end
    ActiveRecord::Base.connection.create_table :weasels_mood_enum do |t|; end
    ActiveRecord::Base.connection.create_table :pandas_hunger_level_enum do |t|; end

    EnumWeasel::Generators::Tables::Deletion.new({}, ["weasels_status_enum", "weasels_mood_enum"]).call
    
    expect(ActiveRecord::Base.connection.tables).to match_array ["pandas_hunger_level_enum"]
  end
end
