require 'rails_helper'

describe 'User' do
  before(:all) do
    user = create(:user)
    10.times do
      @user.orders.create!
    end
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  scenario 'can see their orders' do
    visit dashboard_path


  end
end