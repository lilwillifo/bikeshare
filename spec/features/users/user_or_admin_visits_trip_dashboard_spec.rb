require 'rails_helper'

describe 'The trips dashboard' do

  before(:each) do
    @user = create(:user)
    @station = create_list(:station, 2)
    @trips = create_list(:trip, 5)
  end

  describe 'for a user or admin' do
    it 'has the average duration' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit '/trips-dashboard'

      expect(page).to have_content('Average Duration: 3 seconds')
  end
end
