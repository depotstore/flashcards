require 'rails_helper'

describe 'profile of another user' do
  let!(:user) { create(:user) }
  let!(:another_user) { create(:user, email: 'user2@example.com') }
  let!(:card) { create(:card, user: user) }
  let!(:another_card) do
    create(:card, user: another_user,
                  original_text: 'test',
                  translated_text: 'тест')
  end

  before(:each) do
    visit root_path
  end
  context 'access to cards (user)' do
    before(:each) do
      login(user.email, '123')
      click_link 'Все карточки'
    end
    it 'has access to own cards' do
      expect(page).to have_content 'картинка'
    end
    it 'does not have access to another user cards' do
      expect(page).not_to have_content 'тест'
    end
  end

  context 'access to cards (another_user)' do
    before(:each) do
      login(another_user.email, '123')
      click_link 'Все карточки'
    end
    it 'has access to own cards' do
      expect(page).to have_content 'тест'
    end
    it 'does not have access to user cards' do
      expect(page).not_to have_content 'картинка'
    end
  end
end
