require 'spec_helper'

describe EnumWeasel::Generators do
  let (:table_creation) { double(:table_creation, call: nil) }
  let (:table_deletion) { double(:table_deletion, call: nil) }
  let (:data_creation) { double(:data_creation, call: nil) }
  let (:data_deletion) { double(:data_deletion, call: nil) }

  let (:generator) do 
    generator = EnumWeasel::Generators.new
    generator.table_creation = table_creation
    generator.table_deletion = table_deletion
    generator.data_creation = data_creation
    generator.data_deletion = data_deletion
    generator
  end

  it 'creates new tables' do
    expect(table_creation).to receive :call
  end

  it 'delets old tables' do
    expect(table_deletion).to receive :call
  end

  it 'creates new data' do
    expect(data_creation).to receive :call
  end

  it 'deletes old data' do
    expect(data_deletion).to receive :call
  end

  after do
    generator.call
  end
end
