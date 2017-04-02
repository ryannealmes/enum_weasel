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

  it "handles no enums on single model" do
    ActiveRecord::Schema.define do
      create_table :weasels do |t|
      end
    end

    class Weasel < ActiveRecord::Base; end

    enums = EnumWeasel::GetAllModelEnums.new.call

    expect(enums).to eq({})      
  end

  it "handles single enum on single model" do
    ActiveRecord::Schema.define do
      create_table :weasels do |t|
        t.integer :status
      end
    end

    class Weasel < ActiveRecord::Base
      enum status: { ping: 1, pong: 2 }
    end

    enums = EnumWeasel::GetAllModelEnums.new.call

    expect(enums).to eq({
      "weasel" => ["status"]
    })      
  end

  it "handles multiple enums on single model" do
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

    enums = EnumWeasel::GetAllModelEnums.new.call

    expect(enums).to eq({
      "weasel" => ["mood", "status"]
    })     
  end

  it "handles multiple enums on multiple models" do
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

    enums = EnumWeasel::GetAllModelEnums.new.call

    expect(enums).to eq({
      "weasel" => ["mood", "status"],
      "panda" => ["hunger_level"]
    })     
  end
end
