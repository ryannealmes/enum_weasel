require 'spec_helper'

describe EnumWeasel::Generators::Tables::Deletion do
  before do
    ActiveRecord::Base.establish_connection(adapter: 'sqlite3',
                                            database: ':memory:')
  end

  let(:connection) { ActiveRecord::Base.connection }

  it 'deletes a single enum reference table' do
    connection.create_table :weasels_status_enum do |t|; end

    described_class.new({}, %w(weasels_status_enum)).call

    expect(connection.tables.any?).to be false
  end

  it 'deletes multiple enum reference tables' do
    connection.create_table :weasels_status_enum do |t|; end
    connection.create_table :weasels_mood_enum do |t|; end

    described_class.new({}, %w(weasels_status_enum weasels_mood_enum)).call

    expect(connection.tables.any?).to be false
  end

  it 'does not delete incorrect enum reference tables' do
    connection.create_table :weasels_status_enum do |t|; end
    connection.create_table :weasels_mood_enum do |t|; end
    connection.create_table :pandas_hunger_level_enum do |t|; end

    described_class.new({}, %w(weasels_status_enum weasels_mood_enum)).call

    expect(ActiveRecord::Base.connection.tables).to match_array %w(pandas_hunger_level_enum)
  end
end
