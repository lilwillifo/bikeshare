require 'rails_helper'

RSpec.describe Trip, type: :model do
  context 'Validations' do
    it { should validate_presence_of(:duration) }
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
    it { should validate_presence_of(:bike_id) }
    it { should validate_presence_of(:subscription_type) }
  end

  context 'Relationships' do
    it { is_expected.to belong_to(:start_station) }
    it { is_expected.to belong_to(:end_station) }
  end

  context 'Methods' do
    describe '#time_string' do
      it 'should return the time as a human readable string' do
        date = Time.now
        trip = Trip.new(
          duration: 45,
          start_date: date,
          end_date: date + 45.seconds,
          bike_id: 1,
          subscription_type: 'Premium',
          zip_code: 80202,
          start_station_id: 1,
          end_station_id: 1
        )

        trip2 = Trip.new(
          duration: 4382,
          start_date: date,
          end_date: date + 1.hours + 13.minutes + 2.seconds,
          bike_id: 1,
          subscription_type: 'Premium',
          zip_code: 80202,
          start_station_id: 1,
          end_station_id: 1
        )

        expect(trip.time_string).to eq('45 seconds')
        expect(trip2.time_string).to eq('1 hour, 13 minutes, 2 seconds')
      end
    end
  end
end
