require 'rails_helper'

describe 'user login and logout russian' do
  let!(:user) { create(:user, language: 'ru') }

  context 'restricted access without login ru' do
    before(:each) do
      visit root_path(locale: 'ru')
    end
    it 'does not have access to create new deck' do
      visit new_deck_path(locale: 'ru')
      expect(page).not_to have_button t(submit_create, model: t(model_deck_ru))
    end

    it 'does not have access to edit profile' do
      expect(page).not_to have_content t('users.edit.edit_profile')
    end
  end

  context 'has access to pages after login and does not after logout en' do
    let!(:deck) { create(:deck, user: user) }

    before(:each) do
      login(user.email, '123', 'ru')
      visit root_path(locale: 'ru')
    end

    it 'has access to create new deck' do
      visit new_deck_path(locale: 'ru')
      expect(page).to have_button t(submit_create, model: t(model_deck_ru))
    end

    it 'has access to edit profile' do
      click_link t('users.edit.edit_profile')
      expect(page).to have_content(t('users.edit.edit_profile'), count: 2)
    end

    it 'does not have access to create new card after logout' do
      click_link 'Выйти'
      visit new_card_path(locale: 'ru')
      expect(page).not_to have_button t(submit_create, model: t(model_card_ru))
    end

    it 'does not have access to edit profile after logout' do
      click_link 'Выйти'
      expect(page).not_to have_content t('users.edit.edit_profile')
    end
  end
end
