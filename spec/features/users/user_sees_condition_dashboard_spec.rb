require 'rails_helper'

describe 'As a registered user' do
  context 'when I visit the conditions dashboard' do
    it 'shows the rides broken down by weather' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      conditions = create_list(:condition, 3)
      condition_ids = conditions.pluck(:id)
      station = create(:station)
      trips = create_list(:trip, 10)
        trips.map do |trip|
          trip.update(condition_id: condition_ids.sample)
        end

      visit '/conditions-dashboard'


      expect(page).to have_content('High Temperature between 0.0 - 10.0 (F):')
      expect(page).to have_content('Precipitation between 0.0 - 0.5 (Inches)')
      expect(page).to have_content('Wind Speed between 0.0 - 4.0 (MPH)')
      expect(page).to have_content('Mean Visibility between 1.0 - 5.0 (Miles)')
    end
  end
end
