require 'rails_helper'

describe 'admin visits stations#index' do
  before(:each) do
    @admin = create(:admin)
    @station = create(:station)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
  end

  describe 'admin visit admin_station#edit' do
    it 'allows the admin to edit station' do
      visit edit_admin_station_path(@station)

      fill_in 'station[name]', with: 'Wookie'
      fill_in 'station[dock_count]', with: '10'
      fill_in 'station[city]', with: 'San Fran'
      fill_in 'station[installation_date]', with: '2018-04-10'
      click_on 'Update Station'

      expect(current_path).to eq('/wookie')
      expect(page).to have_content('Wookie updated!')
      expect(page).to have_content('10')
      expect(page).to have_content('San Fran')
      expect(page).to have_content('2018-04-10')
    end
  end

  describe 'admin visit admin_station#edit' do
    it 'allows the admin to edit station' do
      visit stations_path

      click_link 'Edit'

      fill_in 'station[name]', with: 'Wookie'
      fill_in 'station[dock_count]', with: '10'
      fill_in 'station[city]', with: 'San Fran'
      fill_in 'station[installation_date]', with: '2018-04-10'
      click_on 'Update Station'

      expect(current_path).to eq('/wookie')
      expect(page).to have_content('Wookie updated!')
      expect(page).to have_content('10')
      expect(page).to have_content('San Fran')
      expect(page).to have_content('2018-04-10')
    end
  end
end
