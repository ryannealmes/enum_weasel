require 'spec_helper'

describe EnumWeasel::Generator do
  it 'prints pong' do
    ActiveRecord::Base.establish_connection(adapter: 'sqlite3',
                                            database: ':memory:')

    ActiveRecord::Base.connection.create_table "weasel" do |t|
          t.integer :enum, null: false
          t.string :value, null: false
        end

    expect(ActiveRecord::Base.connection.table_exists?("weasel")).to be(true)
    # expect(EnumWeasel::Generator.new.call).to eq("pong")
  end
end
