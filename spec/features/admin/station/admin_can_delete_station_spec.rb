require 'rails_helper'

describe 'admin wants to delete station' do
  before(:each) do
    @admin = create(:admin)
    @station = create(:station)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
  end

  describe 'admin visit stations_path' do
    it 'to use delete station link' do
      visit stations_path

      click_link 'Delete'

      expect(current_path).to eq(stations_path)
      expect(page).to have_content('Station Deleted!')
      expect(page).to_not have_content(@station.name)
      expect(page).to_not have_content(@station.dock_count)
      expect(page).to_not have_content(@station.city)
      expect(page).to_not have_content(@station.installation_date)
    end
  end

  describe 'admin visit station show' do
    it 'to use edit station link' do
      visit "/#{@station.slug}"

      click_link 'Delete'

      expect(current_path).to eq(stations_path)
      expect(page).to have_content('Station Deleted!')
      expect(page).to_not have_content(@station.name)
      expect(page).to_not have_content(@station.dock_count)
      expect(page).to_not have_content(@station.city)
      expect(page).to_not have_content(@station.installation_date)
    end
  end
end
