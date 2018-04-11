require 'rails_helper'

describe 'As a visitor' do
  before(:each) do
    @accessories = create_list(:accessory, 1)
  end

  describe 'When I visit the "/cart" link' do
    describe 'I click link "Remove" next to an accessory' do
      scenario 'I do not see my accessory listed in my cart' do
        visit accessories_path

        find(".add_accessory_#{@accessories.first.id}").click

        visit '/cart'

        expect(page).to have_content(@accessories[0].title)

        click_on 'Remove'

        expect(current_path).to eq('/cart')
        expect(page).to_not have_content(@accessories[0].title)
      end

      scenario 'I see a flash message telling me I have successfully removed the item' do
        visit accessories_path

        find(".add_accessory_#{@accessories.first.id}").click

        visit '/cart'

        click_on 'Remove'

        expect(page).to have_content("Successfully removed #{@accessories.first.title} from your cart.")
      end

      scenario 'I can click undo on the flash message and item will be added back into my cart' do
        visit accessories_path

        find(".add_accessory_#{@accessories.first.id}").click

        visit '/cart'

        click_on 'Remove'
        click_on 'Back to Accessory'

        expect(page).to have_content(@accessories[0].title)
      end
    end
  end
end
