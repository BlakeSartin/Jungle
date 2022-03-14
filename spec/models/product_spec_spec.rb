require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before(:each) do
      @product = Product.new
      @category = Category.new name: 'Apparel'
    end

    it 'should save with all fields filled in correctly' do
      @correct_product = Product.new(name: 'LHL', price: 100, quantity: 5, category: @category)
      @correct_product.save
      expect(@correct_product).to be_persisted
    end

    it 'should not be valid without a name' do
     expect(@product).to_not be_valid
     expect(@product.errors.messages[:name]).to include('can\'t be blank')
    end

    it 'should not be valid without a price' do
      expect(@product).to_not be_valid
      expect(@product.errors.messages[:price]).to include('can\'t be blank')
    end

    it 'should not be valid without a quantity' do
      expect(@product).to_not be_valid
      expect(@product.errors.messages[:quantity]).to include('can\'t be blank')
    end

    it 'should not be valid without a category' do
      expect(@product).to_not be_valid
      expect(@product.errors.messages[:category]).to include('can\'t be blank')
    end
  end
end
