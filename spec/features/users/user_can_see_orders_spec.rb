require 'rails_helper'

describe 'User' do
  before(:each) do
    DatabaseCleaner.clean
    @user = create(:user)
    @user2 = create(:user)

    10.times do
      @user.orders.create!(status: 'ordered')
    end

    5.times do
      @user2.orders.create!(status: 'ordered')
    end
  end

  after(:each) do
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

    visit order_path(@user.orders.first)

    expect(page).to have_http_status(200)
    expect(page).to have_content("Order ##{@user.orders.first.id}")
  end

  scenario 'can not see an order than isn\'t theirs' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit order_path(@user2.orders.first)
    expect(page).to have_http_status(404)

    visit order_path(1000)
    expect(page).to have_http_status(404)
  end
end