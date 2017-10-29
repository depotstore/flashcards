require 'rails_helper'

describe 'checking answer' do
  let!(:user) { create(:user, language: 'ru') }
  let!(:deck) { create(:deck, user: user) }
  let!(:card) { create(:card, deck: deck) }

  before(:each) do
    login(user.email, '123', 'ru')
  end

  context 'looking at the card for review' do
    it "has word for translation"  do
      expect(page).to have_content card.translated_text
    end
  end

  context 'entering translation and checking answer' do
    it "returns 'Правильно' when user enters right answer" do
      fill_in(:translation, with: 'picture')
      click_button('Проверить')
      expect(page).to have_content 'Правильно'
    end
    it "returns 'Не правильно' when user enters wrong answer" do
      fill_in(:translation, with: 'wrong')
      click_button('Проверить')
      expect(page).to have_content 'Не правильно'
    end
  end
end
