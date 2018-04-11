require 'rails_helper'

describe 'admin visits stations#index' do
  before(:each) do
    @admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
  end

  describe 'admin visit admin_station#new' do
    it 'allows the admin to create new station' do
      visit new_admin_station_path

      fill_in 'station[name]', with: 'Wookie'
      fill_in 'station[dock_count]', with: '10'
      fill_in 'station[city]', with: 'San Fran'
      fill_in 'station[installation_date]', with: Time.now
      click_on 'Create Station'

      expect(current_path).to eq('/wookie')
      expect(page).to have_content('Wookie')
    end
  end
end
