require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    subject(:product) { described_class.new(name: 'Example', price: 10, quantity: 5, category: 'Example Category') }

    context 'when name is present' do
      it 'should be valid' do
        expect(product).to be_valid
      end
    end

    context 'when name is not present' do
      it 'should not be valid' do
        product.name = nil
        product.valid?
        expect(product.errors.full_messages).to include("Please provide a name")
      end
    end

    context 'when price is present' do
      it 'should be valid' do
        expect(product).to be_valid
      end
    end

    context 'when price is not present' do
      it 'should not be valid' do
        product.price = nil
        product.valid?
        expect(product.errors.full_messages).to include("Please provide a price")
      end
    end

    context 'when quantity is present' do
      it 'should be valid' do
        expect(product).to be_valid
      end
    end

    context 'when quantity is not present' do
      it 'should not be valid' do
        product.quantity = nil
        product.valid?
        expect(product.errors.full_messages).to include("Please provide a quantity")
      end
    end

    context 'when category is present' do
      it 'should be valid' do
        expect(product).to be_valid
      end
    end

    context 'when category is not present' do
      it 'should not be valid' do
        product.category = nil
        product.valid?
        expect(product.errors.full_messages).to include("Please provide a category")
      end
    end
  end
end

