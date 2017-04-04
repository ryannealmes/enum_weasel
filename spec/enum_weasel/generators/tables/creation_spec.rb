require 'spec_helper'

describe EnumWeasel::Generators::Tables::Creation do
  before do
    ActiveRecord::Base.establish_connection(adapter: 'sqlite3',
                                            database: ':memory:')
  end

  it 'creates a single enum reference table' do
    model_enums = { 'weasel' => ['status'] }

    described_class.new(model_enums, []).call

    reference_table_exists = ActiveRecord::Base.connection.tables.select do |key|
      key.to_s == 'weasels_status_enum'
    end.any?

    expect(reference_table_exists).to be true
  end

  it 'creates multiple enum reference tables for a single model' do
    model_enums = { 'weasel' => %w(status mood) }

    described_class.new(model_enums, []).call

    reference_tables = ActiveRecord::Base.connection.tables.select do |key|
      key =~ /_enum/
    end

    expect(reference_tables).to match_array %w(weasels_status_enum weasels_mood_enum)
  end

  it 'creates multiple enum reference tables for multiple models' do
    model_enums = {
      'weasel' => %w(status mood),
      'panda' => ['hunger_level']
    }

    described_class.new(model_enums, []).call

    reference_tables = ActiveRecord::Base.connection.tables.select do |key|
      key =~ /_enum/
    end

    expected = %w(weasels_status_enum weasels_mood_enum pandas_hunger_level_enum)
    expect(reference_tables).to match_array expected
  end

  it 'does not create duplicate tables' do
    model_enums = { 'weasel' => ['status'] }

    described_class.new(model_enums, []).call
    described_class.new(model_enums, []).call

    reference_table_exists = ActiveRecord::Base.connection.tables.select do |key| 
      key.to_s == 'weasels_status_enum' 
    end.any?

    expect(reference_table_exists).to be true
  end
end
