require 'rails_helper'

describe OrderAccessory, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:quantity) }
  end

  describe 'relationships' do
    it { is_expected.to belong_to(:order) }
    it { is_expected.to belong_to(:accessory) }
  end

  describe 'models' do
    describe '#subtotal' do
      it 'should return the subtotal for an accessory' do
        order = create(:order)
        accessory = create(:accessory)
        order_accessory = OrderAccessory.create!(order: order, accessory: accessory, quantity: 3)

        expect(order_accessory.subtotal).to eq(15)
      end
    end
  end
end
