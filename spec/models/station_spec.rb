require 'rails_helper'

describe Station, type: :model do
  context 'validations' do
    it {should validate_presence_of :name}
    it { should validate_presence_of :dock_count }
    it { should validate_presence_of :city }
    it { should validate_presence_of :installation_date }
  end

  context 'Relationships' do
    it { is_expected.to have_many(:start_trips) }
    it { is_expected.to have_many(:end_trips) }
  end

  context 'Instance Methods' do
    before(:each) do
      DatabaseCleaner.clean
      @station = create(:station)
      create(:condition)
      @trips_from_station = create_list(:trip, 3, start_station: @station)
      @trips_end_station = create_list(:trip, 4, end_station: @station)
    end

    after(:each) do
      DatabaseCleaner.clean
    end

    describe '.trips_from' do
      it 'should return a count of the trips from that station' do
        expect(@station.trips_from).to be(3)
      end
    end

    describe '.trips_to' do
      it 'should return a count of the trips to that station' do
        expect(@station.trips_to).to be(3)
      end
    end
  end

  context 'Class Methods' do
    before(:each) do
      DatabaseCleaner.clean
      @stations = create_list(:station, 5)
      @stations.each_with_index do |station, i|
        station.dock_count = 5 * (i+1)
        station.save!
      end
    end

    after(:each) do
      DatabaseCleaner.clean
    end

    describe '.avg_bikes' do
      it 'should calculate the average number of bicycles available' do
        expect(Station.avg_bikes).to be(15)
      end
    end

    describe '.max_bike_count' do
      it 'should calculate the maximum number of bicycles available' do
        expect(Station.max_bike_count).to be(25)
      end
    end

    describe '.max_bikes' do
      it 'should return the stations with the most bikes' do
        station = create(:station)
        station.dock_count = 25
        station.save!

        expected = Station.all[-2..-1]
        expect(Station.max_bikes).to eq(expected)
      end
    end

    describe '.min_bike_count' do
      it 'should calculate the minimum number of bicycles available' do
        expect(Station.min_bike_count).to be(5)
      end
    end

    describe '.min_bike' do
      it 'should return the stations with the fewest bikes' do
        station = create(:station)
        station.dock_count = 5
        station.save!

        expected = [Station.first, Station.last]
        expect(Station.min_bikes).to eq(expected)
      end
    end

    describe '.newest_station' do
      it 'should return the newest station' do
        station = create(:station)
        station.installation_date = Date.new(2020, 10, 4)
        station.save!

        expect(Station.newest).to eq(station)
      end
    end

    describe '.oldest_station' do
      it 'should return the oldest station' do
        station = create(:station)
        station.installation_date = Date.new(1969, 10, 4)
        station.save!

        expect(Station.oldest).to eq(station)
      end
    end
  end
end
