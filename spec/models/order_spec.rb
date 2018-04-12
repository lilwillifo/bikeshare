require 'rails_helper'

describe Order, type: :model do
  describe 'relationships' do
    it { is_expected.to belong_to(:user) }

    it { is_expected.to have_many(:order_accessories) }
    it { is_expected.to have_many(:accessories).through(:order_accessories) }
  end

  describe 'methods' do
    before(:all) do
      DatabaseCleaner.clean
    end

    after(:all) do
      DatabaseCleaner.clean
    end

    context '#total' do
      it 'should calculate the total order cost' do
        user = create(:user)
        order = Order.create!(user: user)

        accessories = create_list(:accessory, 3)

        accessories.each do |accessory|
          OrderAccessory.create!(order: order, accessory: accessory, quantity: 1)
        end

        expect(order.total).to eq(15.0)
      end
    end
  end
end