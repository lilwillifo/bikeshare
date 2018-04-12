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
            expect(page).to have_link('Reactivate')
          else
            expect(page).to have_link('Retire')
          end
        end
      end


    end
  end
end
