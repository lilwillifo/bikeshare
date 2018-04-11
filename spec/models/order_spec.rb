require 'rails_helper'

describe Order, type: :model do
  it { is_expected.to belong_to(:user) }

  it { is_expected.to have_many(:order_accessories) }
  it { is_expected.to have_many(:accessories).through(:order_accessories) }
end