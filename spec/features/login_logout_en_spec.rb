require 'rails_helper'

describe 'user login and logout english' do
  let!(:user) { create(:user, language: 'en') }

  context 'restricted access without login en' do
    before(:each) do
      visit root_path(locale: 'en')
    end
    it 'does not have access to create new deck' do
      visit new_deck_path(locale: 'en')
      expect(page).not_to have_button t(submit_create, model: Deck)
    end

    it 'does not have access to edit profile' do
      expect(page).not_to have_content t('users.edit.edit_profile')
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
      expect(page).to have_button t(submit_create, model: Deck)
    end

    it 'has access to edit profile' do
      click_link 'Edit Profile'
      expect(page).to have_content(t('users.edit.edit_profile'), count: 2)
    end

    it 'does not have access to create new card after logout' do
      click_link 'Logout'
      visit new_card_path(locale: 'en')
      expect(page).not_to have_button t(submit_create, model: Card)
    end

    it 'does not have access to edit profile after logout' do
      click_link 'Logout'
      expect(page).not_to have_content(t('users.edit.edit_profile'))
    end
  end
end
