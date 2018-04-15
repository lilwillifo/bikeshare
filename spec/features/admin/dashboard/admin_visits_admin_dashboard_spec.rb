require 'rails_helper'

describe 'As an admin' do
  it 'I can login and see my dashboard' do
    admin = create(:admin)

    visit '/'
    click_on 'Login'

    expect(current_path).to eq(login_path)

    fill_in 'username', with: admin.username
    fill_in 'password', with: admin.password
    click_on 'Submit'

    expect(current_path).to eq('/admin/dashboard')
    within('nav') do
      expect(page).to have_content("Logged in as Admin User: #{admin.username}")
    end
    expect(page).to have_link('Logout')
    expect(page).to_not have_link('Login')
  end
  context 'I can link to admin bike shop' do
    it 'and see all accessories both active and inactive' do
      admin = create(:admin)
      accessories = create_list(:accessory, 4)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_dashboard_path
      click_on 'View All Accessories'

      expect(current_path).to eq('/admin/bike-shop')

      accessories.each do |accessory|
        expect(page).to have_content(accessory.title)
        expect(page).to have_content(accessory.description)
        expect(page).to have_content(accessory.price)

        within(".accessory_#{accessory.id}") do
          expect(page).to have_link('Edit')
          if accessory.role = 'active'
            expect(page).to have_link('Retire')
          else
            expect(page).to have_link('Reactivate')
          end
        end
      end
    end
  end
  context 'I see all orders' do
    before :each do
      @admin = create(:admin)
      @users = create_list(:user, 5)
      @order_1 = @users[0].orders.create!(status: 'Ordered')
      @order_2 = @users[0].orders.create!(status: 'Ordered')
      @order_3 = @users[0].orders.create!(status: 'Paid')
      @order_4 = @users[1].orders.create!(status: 'Cancelled')
      @order_5 = @users[1].orders.create!(status: 'Cancelled')
      @order_6 = @users[2].orders.create!(status: 'Completed')
      @order_7 = @users[3].orders.create!(status: 'Paid')
      @order_8 = @users[3].orders.create!(status: 'Completed')
      @order_9 = @users[4].orders.create!(status: 'Ordered')
      @orders = [@order_1, @order_2, @order_3, @order_4, @order_5, @order_6, @order_7, @order_8, @order_9]
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    end
    it 'I can see the total number of orders for each status and a link to order show' do
      visit admin_dashboard_path

      expect(page).to have_content('Ordered: 3')
      expect(page).to have_content('Paid: 2')
      expect(page).to have_content('Cancelled: 2')
      expect(page).to have_content('Completed: 2')

      expect(page).to have_link("Order ##{@order_1.id}")
      click_on "Order ##{@order_1.id}"
      expect(current_path).to eq(admin_order_path(@order_1))
    end
    it 'and I can filter them by status type' do
      visit admin_dashboard_path

      click_on 'Ordered'

      expect(page).to have_content('All Orders with Status: Ordered')
      expect(page).to have_content("Order ##{@order_1.id}")
      expect(page).to_not have_content("Order ##{@order_3.id}")
      expect(page).to have_link('Paid')
    end
  end
end
