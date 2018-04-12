require 'rails_helper'

describe OrderAccessory, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:quantity) }
  end

  describe 'relationships' do
    it { is_expected.to belong_to(:order) }
    it { is_expected.to belong_to(:accessory) }
  end
end
