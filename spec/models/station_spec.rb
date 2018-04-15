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

  context "Methods" do
    describe ".avg_bikes" do
      it 'should calculate the average number of bicycles available' do
        stations = create_list(:station, 5)
        stations.each_with_index do |station, i|
          station.dock_count = 5 * (i+1)
          station.save!
        end

        expect(Station.avg_bikes).to be(15)
      end
    end
  end
end
