require 'rails_helper'

describe 'A logged in user' do
  before(:each) do
    DatabaseCleaner.clean
    @user = create(:user)
    @accessories = create_list(:accessory, 3)
  end

  scenario 'can checkout from cart' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    @accessories.each do |accessory|
      visit accessories_path
      find(".add_accessory_#{accessory.id}").click
    end

    visit '/cart'

    click_on 'Checkout'

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('Successfully submitted your order totaling $15.00')

    click_on('Order #1')

    expect(current_path).to eq(order_path(1))
  end

  scenario 'can see their orders' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    order = @user.orders.create!(status: 'ordered')

    @accessories.each do |accessory|
      OrderAccessory.create!(order: order, accessory: accessory, quantity: 1)
    end

    visit order_path(order)

    expect(page).to have_content("Order ##{order.id}")

    order.order_accessories.each do |item|
      within("#accessory_#{item.accessory.id}") do
        expect(page).to have_content(item.accessory.title)
        expect(page).to have_content(item.quantity)
        expect(page).to have_content(ActiveSupport::NumberHelper.number_to_currency(item.quantity * item.accessory.price))
      end
    end

    expect(page).to have_content(ActiveSupport::NumberHelper.number_to_currency(order.total))
    expect(page).to have_content(order.status)
    expect(page).to have_content(order.created_at)
  end

  scenario 'can NOT see another users orders' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    user = create(:user)

    order = user.orders.create!(status: 'ordered')

    @accessories.each do |accessory|
      OrderAccessory.create!(order: order, accessory: accessory, quantity: 1)
    end

    visit order_path(order)

    expect(page).to have_http_status(404)
  end

  scenario 'sees when order was completed or cancelled' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    order = @user.orders.create!(status: 'completed')
    order2 = @user.orders.create!(status: 'cancelled')

    @accessories.each do |accessory|
      OrderAccessory.create!(order: order, accessory: accessory, quantity: 1)
      OrderAccessory.create!(order: order2, accessory: accessory, quantity: 1)
    end

    visit order_path(order)

    expect(page).to have_content("Completed on #{order.updated_at.to_s}")

    visit order_path(order2)

    expect(page).to have_content("Cancelled on #{order2.updated_at.to_s}")
  end
end
