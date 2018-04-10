require 'rails_helper'

describe Station, type: :model do
  context 'validations' do
    it {should validate_presence_of :name}
    it { should validate_presence_of :dock_count }
    it { should validate_presence_of :city }
    it { should validate_presence_of :installation_date }
  end

  context "Relationships" do
    it { is_expected.to have_many(:start_trips) }
    it { is_expected.to have_many(:end_trips) }
  end
end
