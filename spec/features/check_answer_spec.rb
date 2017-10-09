require 'rails_helper'

describe 'checking answer' do
  subject!(:card) { FactoryGirl.create(:card) }
  before(:each) do
    card.update_attribute(:review_date, -3.days.from_now)
    visit root_path
  end

  context 'looking at the card for review' do
    it 'has Translation' do
      expect(page).to have_content 'Translation'
    end
    it 'has Проверить' do
      expect(page).to have_button 'Проверить'
    end
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
