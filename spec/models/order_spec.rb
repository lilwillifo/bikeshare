require 'rails_helper'

describe Order, type: :model do
  before(:all) do
    DatabaseCleaner.clean
  end

  after(:all) do
    DatabaseCleaner.clean
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:status) }
  end

  describe 'relationships' do
    it { is_expected.to belong_to(:user) }

    it { is_expected.to have_many(:order_accessories) }
    it { is_expected.to have_many(:accessories).through(:order_accessories) }
  end

  describe 'instance methods' do
    context '#total' do
      it 'should calculate the total order cost' do
        user = create(:user)
        order = Order.create!(user: user, status: 'Ordered')

        accessories = create_list(:accessory, 3)

        accessories.each do |accessory|
          OrderAccessory.create!(order: order, accessory: accessory, quantity: 1)
        end

        expect(order.total).to eq(15.0)
      end
    end
  end
  describe 'class methods' do
    before :each do
      @user = create(:user)
      @order_1 = Order.create!(user: @user, status: 'Ordered')
      @order_2 = Order.create!(user: @user, status: 'Ordered')
      @order_3 = Order.create!(user: @user, status: 'Completed')
      @order_3 = Order.create!(user: @user, status: 'Paid')
      @order_3 = Order.create!(user: @user, status: 'Paid')
      @order_3 = Order.create!(user: @user, status: 'Paid')
      @order_3 = Order.create!(user: @user, status: 'Cancelled')
      @order_3 = Order.create!(user: @user, status: 'Cancelled')
    end
    context '.ordered_count' do
      it 'counts the number of orders with status: Ordered' do
        expect(Order.ordered_count).to eq(2)
      end
    end
    context '.paid_count' do
      it 'counts the number of orders with status: Paid' do
        expect(Order.paid_count).to eq(3)
      end
    end
    context '.completed_count' do
      it 'counts the number of orders with status: Completed' do
        expect(Order.completed_count).to eq(1)
      end
    end
    context '.cancelled_count' do
      it 'counts the number of orders with status: Cancelled' do
        expect(Order.cancelled_count).to eq(2)
      end
    end
  end
end
