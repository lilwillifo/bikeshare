require 'rails_helper'

describe 'admin wants to delete station' do
  before(:each) do
    @admin = create(:admin)
    @station = create(:station)
  end

  describe 'admin visit stations_path' do
    it 'to use delete station link' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      visit stations_path

      within(".station_#{@station.id}") do
        find(:xpath, ".//a[i[contains(@class, 'fas fa-trash-alt')]]").click
      end

      expect(current_path).to eq(stations_path)
      expect(page).to have_content('Station 2 Deleted!')
      expect(page).to_not have_content(@station.dock_count)
      expect(page).to_not have_content(@station.city)
      expect(page).to_not have_content(@station.installation_date)
    end
  end

  describe 'admin visit station show' do
    it 'to use edit station link' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      visit "/#{@station.slug}"

      find(:xpath, ".//a[i[contains(@class, 'fas fa-trash-alt')]]").click

      expect(current_path).to eq(stations_path)
      expect(page).to have_content('Station 3 Deleted!')
      expect(page).to_not have_content(@station.dock_count)
      expect(page).to_not have_content(@station.city)
      expect(page).to_not have_content(@station.installation_date)
    end
  end

  describe 'as normal user' do
    it 'does not allow default user to see delete link' do
      user = User.create(username: 'fern@gully.com',
                         password: 'password')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit stations_path
      expect(page).to_not have_content('Edit')
    end
  end

  describe 'as visitor' do
    it 'does not allow visitor to see delete link' do

      visit stations_path
      expect(page).to_not have_content('Delete')
    end
  end
end
