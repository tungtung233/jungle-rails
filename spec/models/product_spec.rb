require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it "is valid if product name, price, quantity and category is provided" do
      @category = Category.create(name: 'example')
      @product = @category.products.create(name: 'xyz', price: 123, quantity: 1)

      expect(@product.errors.full_messages).to eql([])
      expect(@product).to be_valid
    end
    
    it "is invalid if product name is not provided" do
      @category = Category.create(name: 'example')
      @product = @category.products.create(name: nil, price: 123, quantity: 1)

      expect(@product.errors.full_messages).to eql(["Name can't be blank"])
      expect(@product).to_not be_valid
    end

    it "is invalid if product price is not provided" do
      @category = Category.create(name: 'example')
      @product = @category.products.create(name: 'xyz', price: nil, quantity: 1)

      expect(@product.errors.full_messages).to eql(["Price cents is not a number", "Price is not a number", "Price can't be blank"])
      expect(@product).to_not be_valid
    end

    it "is invalid if product quantity is not provided" do
      @category = Category.create(name: 'example')
      @product = @category.products.create(name: 'xyz', price: 123, quantity: nil)

      expect(@product.errors.full_messages).to eql(["Quantity can't be blank"])
      expect(@product).to_not be_valid
    end

    it "is invalid if product category is not provided" do
      @product = Product.create(name: 'xyz', price: 123, quantity: 1, category: nil)

      expect(@product.errors.full_messages).to eql(["Category can't be blank"])
      expect(@product).to_not be_valid
    end
  end
end
