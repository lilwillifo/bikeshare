require 'rails_helper'

describe 'As a visitor' do
  before(:each) do
    @accessories = create_list(:accessory, 2)
  end

  describe 'When I visit the "/cart" link' do
    describe 'I click link "Remove" next to an accessory' do
      scenario 'I do not see my accessory listed in my cart' do
        visit accessories_path

        find(".add_accessory_#{@accessories.first.id}").click
        find(".add_accessory_#{@accessories.first.id}").click

        visit '/cart'

        expect(page).to have_content(@accessories[0].title)
        expect(page).to have_content(@accessories[1].title)
      end
    end
  end
end
