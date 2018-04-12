require 'rails_helper'

describe 'User' do
  before(:all) do
    DatabaseCleaner.clean
    @user = create(:user)
    10.times do
      @user.orders.create!(status: 'ordered')
    end
  end

  after(:all) do
    DatabaseCleaner.clean
  end

  scenario 'can see their orders' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit dashboard_path

    within('.orders') do
      10.times do |n|
        expect(page).to have_content("Order ##{n+1}")
      end
    end
  end
end