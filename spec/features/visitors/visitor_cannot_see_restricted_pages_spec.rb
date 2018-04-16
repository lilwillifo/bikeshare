require 'rails_helper'

describe 'Visitor' do
  before(:each) do
    DatabaseCleaner.clean
    @user = create(:user)
  end
  scenario 'cannot access /account' do
    visit edit_user_path(@user)

    expect(current_path).to eq(login_path)
  end

  scenario 'cannot see a users orders' do
    order = @user.orders.create!(status: 'ordered')

    visit order_path(order)

    expect(page).to have_http_status(404)
  end

  scenario 'cannot access admin dashboard' do
    visit admin_dashboard_path
    expect(page).to have_http_status(404)
  end

  scenario 'cannot access stations/trips/etc. dashboards' do
    visit stations_dashboard_path
    expect(current_path).to eq(login_path)
  end
end