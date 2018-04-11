require 'rails_helper'

describe 'admin visits trips#index' do
  before(:each) do
    @admin = create(:admin)
    @station = create(:station)
    @station2 = create(:station)
  end

  describe 'admin visit admin_trip#new' do
    it 'allows the admin to create new station' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      visit new_admin_station_path

      fill_in 'trip[start_date]', with: '2018-01-09 18:27:55'
      fill_in 'trip[end_date]', with: '2018-01-09 22:27:55'
      fill_in 'trip[bike_id]', with: 8
      fill_in 'trip[subscription_type]', with: 'Premium'
      fill_in 'trip[zip_code]', with: 88888
      fill_in 'trip[start_station_id]', with: 1
      fill_in 'trip[start_end_id]', with: 2
      click_on 'Create Trip'

      expect(current_path).to eq('/wookie')
      expect(page).to have_content('2018-01-09 18:27:55')
      expect(page).to have_content('2018-01-09 22:27:55')
      expect(page).to have_content('8')
      expect(page).to have_content('Premium')
      expect(page).to have_content('88888')
      expect(page).to have_content('1')
      expect(page).to have_content('2')
    end
  end
end
