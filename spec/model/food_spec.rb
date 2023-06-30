require 'rails_helper'
RSpec.describe Food, type: :model do
  before :each do
    @food = Food.create(name: 'Jolof', measurement_unit: 3, price: 1)
  end
  it 'should have a name' do
    food = @food.name
    expect(food).to eq('Jolof')
  end

  it 'should contain the measurement' do
    expect(@food.measurement_unit).to eq 3
  end

  it 'should container the price ' do
    expect(@food.price).to eq 1
  end

  it 'should has a valid attributes' do
    expect(@food).to be_valid
  end
end
