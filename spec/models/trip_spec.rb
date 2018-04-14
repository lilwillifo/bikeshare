require 'rails_helper'

RSpec.describe Trip, type: :model do
  before(:each) do
    date = Time.now
    station1 = Station.create!(
      name: 'bob',
      dock_count: 10,
      city: 'Modena',
      installation_date: Date.new(2012,10,4),
      slug: 'bob'
    )
    station1 = Station.create!(
      name: 'sally',
      dock_count: 35,
      city: 'West',
      installation_date: Date.new(2012,10,4),
      slug: 'sally'
    )
    @trip = Trip.create!(
      duration: 40,
      start_date: date,
      end_date: date + 45.seconds,
      bike_id: 1,
      subscription_type: 'Premium',
      zip_code: 80202,
      start_station_id: 1,
      end_station_id: 1
    )

    @trip2 = Trip.create!(
      duration: 50,
      start_date: date,
      end_date: date + 1.hours + 13.minutes + 2.seconds,
      bike_id: 1,
      subscription_type: 'Premium',
      zip_code: 80202,
      start_station_id: 2,
      end_station_id: 1
    )
    @trip3 = Trip.create!(
      duration: 50,
      start_date: date,
      end_date: date + 1.hours + 13.minutes + 2.seconds,
      bike_id: 1,
      subscription_type: 'Premium',
      zip_code: 80202,
      start_station_id: 2,
      end_station_id: 1
    )
    @trip4 = Trip.create!(
      duration: 50,
      start_date: date,
      end_date: date + 1.hours + 13.minutes + 2.seconds,
      bike_id: 1,
      subscription_type: 'Premium',
      zip_code: 80202,
      start_station_id: 2,
      end_station_id: 2
    )
  end

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
    it { is_expected.to belong_to(:condition) }
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

    describe '#average_duration' do
      it 'should return the average duration of a ride' do
        expect(Trip.average_duration).to eq(47.5)
      end
    end

    describe '#longest_ride' do
      it 'should return the longest ride' do
        expect(Trip.longest_ride).to eq(50)
      end
    end

    describe '#shortest_ride' do
      it 'should return the shortest ride' do
        expect(Trip.shortest_ride).to eq(40)
      end
    end

    describe '#popular start station' do
      it 'should return the most popular start station' do
        expect(Trip.popular_start_station).to eq('sally')
      end
    end

    describe '#popular end station' do
      it 'should return the most popular end station' do
        expect(Trip.popular_end_station).to eq('bob')
      end
    end
  end
end
