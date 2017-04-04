require 'spec_helper'

describe EnumWeasel::GetAllModelEnums do
  before do
    ActiveRecord::Base.establish_connection(adapter: 'sqlite3',
                                            database: ':memory:')
  end

  after do
    Object.send(:remove_const, :Weasel)

    ActiveRecord::Schema.define do
      drop_table :weasels, if_exists: true
      drop_table :pandas, if_exists: true
    end
  end

  it 'no enums on single model' do
    ActiveRecord::Schema.define do
      create_table :weasels do |t|
      end
    end

    class Weasel < ActiveRecord::Base; end

    enums = described_class.new.call

    expect(enums).to eq({})
  end

  it 'single enum on single model' do
    ActiveRecord::Schema.define do
      create_table :weasels do |t|
        t.integer :status
      end
    end

    class Weasel < ActiveRecord::Base
      enum status: { ping: 1, pong: 2 }
    end

    enums = described_class.new.call

    expect(enums).to eq('weasel' => %w(status))
  end

  it 'multiple enums on single model' do
    ActiveRecord::Schema.define do
      create_table :weasels do |t|
        t.integer :status
        t.integer :mood
      end
    end

    class Weasel < ActiveRecord::Base
      enum mood: { happy: 1, angry: 2 }
      enum status: { ping: 1, pong: 2 }
    end

    enums = described_class.new.call

    expect(enums).to eq('weasel' => %w(mood status))
  end

  it 'multiple enums on multiple models' do
    ActiveRecord::Schema.define do
      create_table :weasels do |t|
        t.integer :status
        t.integer :mood
      end

      create_table :panda do |t|
        t.integer :hunger_level
      end
    end

    class Weasel < ActiveRecord::Base
      enum mood: { happy: 1, angry: 2 }
      enum status: { ping: 1, pong: 2 }
    end

    class Panda < ActiveRecord::Base
      enum hunger_level: { will_eat_person: 1, will_eat_bamboo: 2 }
    end

    enums = described_class.new.call

    expect(enums).to eq('weasel' => %w(mood status), 'panda' => %w(hunger_level))
  end
end
