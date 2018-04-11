require 'rails_helper'

describe Order, type: :model do
  it { is_expected.to belong_to(:user) }
end