require 'rails_helper'

RSpec.describe Cat, type: :model do
  it 'should have a name' do
    cat = Cat.create(age: 2, enjoys:'eating birds')
    expect(cat.errors[:name]).to_not be_empty
  end
  it 'should have an age' do
    cat = Cat.create(name: 'marvin', enjoys:'eating birds')
    expect(cat.errors[:age]).to_not be_empty
  end
  it 'should enjoy something' do
    cat = Cat.create(name: 'marvin', age: 2)
    expect(cat.errors[:enjoys]).to_not be_empty
  end
  it 'is not valid if enjoys is less than 10 character' do
    cat = Cat.create(name: 'marvin', age: 2, enjoys: 'meowing')
    expect(cat.errors[:enjoys]).to_not be_empty
  end
end