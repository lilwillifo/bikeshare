require 'rails_helper'

describe 'As an admin' do
  scenario 'I can edit an accessory' do
    admin = create(:admin)
    accessory_1, accesstory_2 = create_list(:accessory, 2)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_accessories_path

    within(".accessory_#{accessory_1.id}") do
      click_on 'Edit'
    end

    expect(current_path).to eq(edit_admin_accessory_path(accessory_1))
    fill_in 'Title', with: "YOLO"
    fill_in 'Price', with: 10
    fill_in 'Description', with: "Renaming cuz I can cuz I'm an admin"

    click_on 'Update'

    expect(current_path).to eq(accessory_path(accessory_1))
    expect(page).to have_content('YOLO')
    expect(page).to have_content(10)
    expect(page).to have_content("Renaming cuz I can cuz I'm an admin")
  end

  describe 'I can change accessory status' do
    scenario 'from active to inactive' do
      admin = create(:admin)
      accessory = create(:accessory)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit edit_admin_accessory_path(accessory)

      expect(page).to have_checked_field('acessory[role]')

      uncheck('accessory[role]')

      click_on 'Update Accessory'

      expect(page).to have_content("#{accessory.name} updated.")

      expect(page).to_not have_button('Add to Cart')
    end
  end
end
