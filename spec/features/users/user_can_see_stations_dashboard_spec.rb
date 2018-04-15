require 'rails_helper'

describe 'As a user/admin' do
  describe 'when I visit the stations dashboard' do
    before(:each) do
      DatabaseCleaner.clean
      @user = create(:user)

      Station.create!(
        name: 'Station A',
        dock_count: 5,
        city: 'San Francisco',
        installation_date: Date.new(2017, 10, 4)
      )
      Station.create!(
        name: 'Station B',
        dock_count: 10,
        city: 'Oakland',
        installation_date: Date.new(2016, 10, 4)
      )
      Station.create!(
        name: 'Station C',
        dock_count: 15,
        city: 'San Diego',
        installation_date: Date.new(2015, 10, 4)
      )
      Station.create!(
        name: 'Station D',
        dock_count: 20,
        city: 'Los Angeles',
        installation_date: Date.new(2014, 10, 4)
      )
      Station.create!(
        name: 'Station E',
        dock_count: 25,
        city: 'San Bernadino',
        installation_date: Date.new(2013, 10, 4)
      )

      @stations = Station.all
    end

    after(:each) do
      DatabaseCleaner.clean
    end

    scenario 'I should see the total number of stations' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit stations_dashboard_path

      expect(page).to have_content("Total Number of Stations: #{@stations.length}")
    end

    scenario 'I should see the average bikes per station' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit stations_dashboard_path

      expect(page).to have_content("Average number of bikes: #{Station.avg_bikes}")
    end

    scenario 'I should see the maximum number of bikes available' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit stations_dashboard_path

      expect(page).to have_content("Maximum bikes available: #{Station.max_bike_count}")
    end

    scenario 'I should see the stations with the most number of bikes' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      station = create(:station)
      station.dock_count = 25
      station.save!

      visit stations_dashboard_path

      expect(page).to have_content("Stations with #{Station.max_bike_count} bikes")

      stations = Station.max_bikes
      within('table#most_bikes') do
        tds = all('td')

        expect(tds.length).to be(stations.length)

        expect(page).to have_link(stations.first.name)
        expect(page).to have_link(stations.last.name)

        click_on stations.first.name
      end

      expect(current_path).to eq("/#{stations.first.slug}")
    end

    scenario 'I should see the minimum number of bikes available' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit stations_dashboard_path

      expect(page).to have_content("Minimum bikes available: #{Station.min_bike_count}")
    end

    scenario 'I should see the stations with the fewest number of bikes' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      station = create(:station)
      station.dock_count = 5
      station.save!

      visit stations_dashboard_path

      expect(page).to have_content("Stations with #{Station.max_bike_count} bikes")

      stations = Station.min_bikes
      within('table#fewest_bikes') do
        tds = all('td')

        expect(tds.length).to be(stations.length)

        expect(page).to have_link(stations.first.name)
        expect(page).to have_link(stations.last.name)

        click_on stations.first.name
      end

      expect(current_path).to eq("/#{stations.first.slug}")
    end

    scenario 'I should see the newest station' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      station = create(:station)
      station.installation_date = Date.new(2020, 10, 4)
      station.save!

      visit stations_dashboard_path

      expect(page).to have_content("Newest station: #{station.name}")
      expect(page).to have_link(station.name)

      click_on station.name

      expect(current_path).to eq("/#{station.slug}")
    end

    scenario 'I should see the oldest station' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      station = create(:station)
      station.installation_date = Date.new(1969, 10, 4)
      station.save!

      visit stations_dashboard_path

      expect(page).to have_content("Oldest station: #{station.name}")
      expect(page).to have_link(station.name)

      click_on station.name

      expect(current_path).to eq("/#{station.slug}")
    end
  end
end