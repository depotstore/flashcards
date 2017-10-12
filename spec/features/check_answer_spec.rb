require 'rails_helper'

describe 'checking answer' do
  let!(:user) { create(:user) }
  let(:card) { build(:card) }

  before(:each) do
    user.cards << card
    card.update_attribute(:review_date, -3.days.from_now)
    login(user.email, '123')
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
