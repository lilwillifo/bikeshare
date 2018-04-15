require 'rails_helper'

RSpec.describe Condition, type: :model do
  context 'validations' do
    it { should validate_presence_of :date }
    it { should validate_presence_of :max_temperature }
    it { should validate_presence_of :mean_temperature }
    it { should validate_presence_of :min_temperature }
    it { should validate_presence_of :mean_humidity }
    it { should validate_presence_of :mean_visibility }
    it { should validate_presence_of :mean_wind_speed }
    it { should validate_presence_of :precipitation }
  end
  describe 'class methods' do
    before :each do
      @stations = create_list(:station, 3)
      @condition_1 = create(:condition, max_temperature: 50, precipitation: 1, mean_wind_speed: 0, mean_visibility: 0)
      @condition_2 = create(:condition, max_temperature: 56, precipitation: 0.9, mean_wind_speed: 3, mean_visibility: 1)
      @condition_3 = create(:condition, max_temperature: 60, precipitation: 0.6, mean_wind_speed: 6, mean_visibility: 1)
      @condition_4 = create(:condition, max_temperature: 68, precipitation: 0.3, mean_wind_speed: 9, mean_visibility: 4)
      @condition_5 = create(:condition, max_temperature: 80, precipitation: 0, mean_wind_speed: 4, mean_visibility: 9)
      @trip_1 = create(:trip, condition: @condition_1)
      @trip_2 = create(:trip, condition: @condition_2)
      @trip_3 = create(:trip, condition: @condition_2)
      @trip_4 = create(:trip, condition: @condition_3)
      @trip_5 = create(:trip, condition: @condition_3)
      @trip_6 = create(:trip, condition: @condition_4)
      @trip_7 = create(:trip, condition: @condition_5)
      @trip_8 = create(:trip, condition: @condition_5)
    end
    describe '.most_rides_by_temp(range)' do
      it 'returns the highest number of rides with a high temperature' do
        expect(Condition.most_rides_by_temp([50, 59.99])).to eq(2)
        expect(Condition.most_rides_by_temp([70, 80])).to eq(2)
      end
    end
    describe '.least_rides_by_temp(range)' do
      it 'returns the lowest number of rides with a high temperature' do
        expect(Condition.least_rides_by_temp([50, 59.99])).to eq(1)
        expect(Condition.least_rides_by_temp([70, 80])).to eq(2)
      end
    end
    describe '.average_rides_by_temp(range)' do
      it 'returns the average number of rides with a high temperature' do
        expect(Condition.average_rides_by_temp([50, 59.99])).to eq(1.5)
        expect(Condition.average_rides_by_temp([70, 80])).to eq(2)
      end
    end
    describe '.most_rides_by_rain(range)' do
      it 'returns the highest number of rides with a certain percipitation' do
        expect(Condition.most_rides_by_rain([0, 0.5])).to eq(2)
        expect(Condition.most_rides_by_rain([0.5, 1])).to eq(2)
      end
    end
    describe '.least_rides_by_rain(range)' do
      it 'returns the lowest number of rides with a certain percipitation' do
        expect(Condition.least_rides_by_rain([0, 0.5])).to eq(1)
        expect(Condition.least_rides_by_rain([0.5, 1])).to eq(1)
      end
    end
    describe '.average_rides_by_rain(range)' do
      it 'returns the average number of rides with a certain percipitation' do

        expect(Condition.average_rides_by_rain([0, 0.5])).to eq(1.5)
        expect(Condition.average_rides_by_rain([0.5, 1])).to eq(1.67)
      end
    end
    describe '.most_rides_by_wind(range)' do
      it 'returns the highest number of rides with a certain wind speed' do

        expect(Condition.most_rides_by_wind([0, 3.9])).to eq(2)
        expect(Condition.most_rides_by_wind([4, 7.9])).to eq(2)
        expect(Condition.most_rides_by_wind([8, 12])).to eq(1)
      end
    end
    describe '.least_rides_by_wind(range)' do
      it 'returns the lowest number of rides with a certain wind speed' do

        expect(Condition.least_rides_by_wind([0, 3.9])).to eq(1)
        expect(Condition.least_rides_by_wind([4, 7.9])).to eq(2)
        expect(Condition.least_rides_by_wind([8, 12])).to eq(1)
      end
    end
    describe '.average_rides_by_wind(range)' do
      it 'returns the average number of rides with a certain wind speed' do

        expect(Condition.average_rides_by_wind([0, 3.9])).to eq(1.5)
        expect(Condition.average_rides_by_wind([4, 7.9])).to eq(2)
        expect(Condition.average_rides_by_wind([8, 12])).to eq(1)
      end
      describe '.most_rides_by_visibility(range)' do
        it 'returns the highest number of rides with a certain visibility' do

          expect(Condition.most_rides_by_visibility([0, 3.9])).to eq(2)
          expect(Condition.most_rides_by_visibility([4, 7.9])).to eq(1)
          expect(Condition.most_rides_by_visibility([8, 12])).to eq(2)
        end
      end
      describe '.least_rides_by_visibility(range)' do
        it 'returns the lowest number of rides with a certain visibility' do

          expect(Condition.least_rides_by_visibility([0, 3.9])).to eq(1)
          expect(Condition.least_rides_by_visibility([4, 7.9])).to eq(1)
          expect(Condition.least_rides_by_visibility([8, 12])).to eq(2)
        end
      end
      describe '.average_rides_by_visibility(range)' do
        it 'returns the average number of rides with a certain visibility' do

          expect(Condition.average_rides_by_visibility([0, 3.9])).to eq(1.67)
          expect(Condition.average_rides_by_visibility([4, 7.9])).to eq(1)
          expect(Condition.average_rides_by_visibility([8, 12])).to eq(2)
        end
      end
    end
  end
end
