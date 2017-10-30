require 'rails_helper'

# describe 'user signup russian' do
#   let(:user) { build(:user) }
#
#   before(:each) do
#     visit signup_path(locale: 'ru')
#     fill_in 'user[email]', with: user.email
#     fill_in 'user[password]', with: '123'
#     fill_in 'user[password_confirmation]', with: '123'
#     select('ru', from: 'user[language]')
#     click_button 'Зарегистрироваться'
#   end
#
#   it 'gets informed about account creation' do
#     expect(page).to have_content 'Аккаунт был успешно создан.'
#   end
#
#   context 'after signup user is logged in' do
#     it 'has access to check translation' do
#       expect(page).to have_content 'Нет карточек для ревью.'
#     end
#
#     it 'has access to all cards' do
#       click_link 'Все карточки'
#       expect(page).to have_content('Все карточки', count: 2)
#     end
#
#     it 'has access to edit profile' do
#       click_link 'Настройки'
#       expect(page).to have_content('Настройки', count: 2)
#     end
#   end
# end
describe 'user signup russian' do
  let(:user) { build(:user) }

  before(:each) do
    visit signup_path(locale: 'ru')
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: '123'
    fill_in 'user[password_confirmation]', with: '123'
    select('ru', from: 'user[language]')
    click_button t("helpers.submit.user.create")
  end

  it 'gets informed about account creation' do
    expect(page).to have_content t("users.create.success")
  end

  context 'after signup user is logged in' do
    it 'has access to check translation' do
      expect(page).to have_content t("static_pages.home.no_cards")
    end

    it 'has access to all cards' do
      all_cards = t('layouts.application.all_cards')
      click_link all_cards
      expect(page).to have_content(all_cards, count: 2)
    end

    it 'has access to edit profile' do
      edit_profile = t('users.edit.edit_profile')
      click_link edit_profile
      expect(page).to have_content(edit_profile, count: 2)
    end
  end
end
