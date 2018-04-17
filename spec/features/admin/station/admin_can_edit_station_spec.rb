require 'rails_helper'

describe 'admin visits stations#index' do
  before(:each) do
    @admin = create(:admin)
    @station = create(:station)
  end

  describe 'admin visit admin_station#edit' do
    it 'allows the admin to edit station' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      visit edit_admin_station_path(@station)

      fill_in 'station[name]', with: 'Wookie'
      fill_in 'station[dock_count]', with: '10'
      fill_in 'station[city]', with: 'San Fran'
      fill_in 'station[installation_date]', with: Date.new(2018, 4, 10)
      click_on 'Update Station'

      expect(current_path).to eq('/wookie')
      expect(page).to have_content('Wookie updated!')
      expect(page).to have_content('10')
      expect(page).to have_content('San Fran')
      expect(page).to have_content(Date.new(2018, 4, 10))
    end
  end

  describe 'admin visit stations_path' do
    it 'to use edit station link' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      visit stations_path

      within(".station_#{@station.id}") do
        find(:xpath, ".//a[i[contains(@class, 'far fa-edit')]]").click
      end

      fill_in 'station[name]', with: 'Wookie'
      fill_in 'station[dock_count]', with: '10'
      fill_in 'station[city]', with: 'San Fran'
      fill_in 'station[installation_date]', with: Date.new(2018,04,10)
      click_on 'Update Station'

      expect(current_path).to eq('/wookie')
      expect(page).to have_content('Wookie updated!')
      expect(page).to have_content('10')
      expect(page).to have_content('San Fran')
      expect(page).to have_content(Date.new(2018,04,10))
    end
  end

  describe 'admin visit station show' do
    it 'to use edit station link' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      visit "/#{@station.slug}"

      find(:xpath, ".//a[i[contains(@class, 'far fa-edit')]]").click

      fill_in 'station[name]', with: 'Wookie'
      fill_in 'station[dock_count]', with: '10'
      fill_in 'station[city]', with: 'San Fran'
      fill_in 'station[installation_date]', with: Date.new(2018,04,10)
      click_on 'Update Station'

      expect(current_path).to eq('/wookie')
      expect(page).to have_content('Wookie updated!')
      expect(page).to have_content('10')
      expect(page).to have_content('San Fran')
      expect(page).to have_content(Date.new(2018,04,10))
    end
  end

  describe 'as normal user' do
    it 'does not allow default user to see admin categories edit' do
      user = User.create(username: 'fern@gully.com',
                         password: 'password')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit edit_admin_station_path(@station)
      expect(page).to_not have_content('Edit Station')
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end

  describe 'as visitor' do
    it 'does not allow visitor to see admin categories edit' do

      visit edit_admin_station_path(@station)
      expect(page).to_not have_content('Edit Station')
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
