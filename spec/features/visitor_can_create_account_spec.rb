require 'rails_helper'

describe 'As a visitor' do
  context 'when I visit the homepage and click login' do
    it 'I see a link to create an account' do
      visit '/'

      expect(page).to have_link('Login')
    end
    context 'when I click create account and fill in my credentials' do
      it 'I should be on the dashboard' do

      end
    end
  end
end
