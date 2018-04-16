require 'rails_helper'

describe 'admin visits wants to add accessory' do
  before(:each) do
    @admin = create(:admin)
  end

  describe 'links to accessory add page' do
    it 'updates database with new accessory and has default image' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      visit admin_accessories_path

      click_link 'Add New Accessory'

      fill_in 'accessory[title]', with: 'Tea'
      fill_in 'accessory[description]', with: 'Full to the max'
      fill_in 'accessory[price]', with: '100'

      click_on 'Create Accessory'

      expect(current_path).to eq(accessory_path(Accessory.all.last))
      expect(page).to have_content('Tea')
      expect(page).to have_content('Full to the max')
      expect(page).to have_content('100')
      expect(page).to have_xpath("//img[contains(@src,'https://www.blogcdn.com/www.engadget.com/media/2012/11/accessories.png')]")
    end
  end

  describe 'links to accessory add page' do
    it 'updates database with new accessory' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      visit admin_accessories_path

      click_link 'Add New Accessory'

      fill_in 'accessory[title]', with: 'Tea'
      fill_in 'accessory[description]', with: 'Full to the max'
      fill_in 'accessory[price]', with: '-100'

      click_on 'Create Accessory'

      expect(current_path).to eq(accessory_path(Accessory.all.last))
      expect(page).to have_content('0')
    end
  end

  describe 'if title is not there for new accessory' do
    it 'does not update database with new accessory' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      visit admin_accessories_path

      click_link 'Add New Accessory'

      fill_in 'accessory[description]', with: 'Full to the max'
      fill_in 'accessory[price]', with: '100'

      click_on 'Create Accessory'

      expect(page).to have_content('Accessory not added.')
    end
  end

  describe 'if description is not there for new accessory' do
    it 'does not update database with new accessory' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      visit admin_accessories_path

      click_link 'Add New Accessory'

      fill_in 'accessory[title]', with: 'Tea'
      fill_in 'accessory[price]', with: '100'

      click_on 'Create Accessory'

      expect(page).to have_content('Accessory not added.')
    end
  end

  describe 'if title is duplicate for new accessory' do
    it 'does not update database with new accessory' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      accessory = Accessory.create!(title: 'bob', description: 'so much stuff', price: 25)

      visit admin_accessories_path

      click_link 'Add New Accessory'

      fill_in 'accessory[title]', with: 'bob'
      fill_in 'accessory[description]', with: 'Full to the max'
      fill_in 'accessory[price]', with: '100'

      click_on 'Create Accessory'

      expect(page).to have_content('Accessory not added.')
    end
  end

  describe 'links to accessory add page' do
    it 'updates database with new accessory' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit admin_accessories_path

      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end

  describe 'links to accessory add page' do
    it 'updates database with new accessory' do
      visit admin_accessories_path

      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
