require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "Validations" do
    it "will save when all 4 fields are valid" do
      @category = Category.create(name: "category")
      @product = Product.new(name: "product", price: 299, quantity: 20, category: @category)
      @product.save!
      expect(@product).to be_valid
    end

    it "requires a valid name" do
      @category = Category.create(name: "category")
      @product = Product.new(price: 299, quantity: 20, category: @category)
      @product.valid?
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it "requires a valid price and for the price to be a number" do
      @category = Category.create(name: "category")
      @product = Product.new(name: "product", quantity: 20, category: @category)
      @product.valid?
      expect(@product.errors.full_messages).to include("Price is not a number")
    end

    it "requires a valid quantity" do
      @category = Category.create(name: "category")
      @product = Product.new(name: "product", price: 299, category: @category)
      @product.valid?
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it "requires a valid category" do
      @category = Category.create(name: "category")
      @product = Product.new(name: "product", price: 299, quantity: 20)
      @product.valid?
      expect(@product.errors.full_messages).to include("Category must exist")
    end

  end
end
