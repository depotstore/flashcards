require 'rails_helper'

describe 'user login and logout english' do
  let!(:user) { create(:user, language: 'en') }

  context 'restricted access without login en' do
    before(:each) do
      visit root_path(locale: 'en')
    end
    it 'does not have access to create new deck' do
      visit new_deck_path(locale: 'en')
      expect(page).not_to have_button 'Create Deck'
    end

    it 'does not have access to edit profile' do
      expect(page).not_to have_content('Edit Profile')
    end
  end

  context 'has access to pages after login and does not after logout en' do
    let!(:deck) { create(:deck, user: user) }

    before(:each) do
      login(user.email, '123', 'en')
      visit root_path(locale: 'en')
    end

    it 'has access to create new deck' do
      visit new_deck_path(locale: 'en')
      expect(page).to have_button 'Create Deck'
    end

    it 'has access to edit profile' do
      click_link 'Edit Profile'
      expect(page).to have_content('Edit Profile', count: 2)
    end

    it 'does not have access to create new card after logout' do
      click_link 'Logout'
      visit new_card_path(locale: 'en')
      expect(page).not_to have_button 'Create flashcard'
    end

    it 'does not have access to edit profile after logout' do
      click_link 'Logout'
      expect(page).not_to have_content('Edit Profile')
    end
  end
end
