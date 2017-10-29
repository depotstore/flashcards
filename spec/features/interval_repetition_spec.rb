require 'rails_helper'

describe 'interval repetition' do
  let!(:user) { create(:user, language: 'ru') }
  let!(:deck) { create(:deck, user: user) }
  let!(:card) { create(:card, deck: deck) }
  before(:each) do
    login(user.email, '123', 'ru')
  end
  context 'checking translation of new card - right answer' do
    it 'increases review_date to 12.hours.from_now' do
      fill_in(:translation, with: 'picture')
      click_button('Проверить')
      card.reload
      expect(card.review_date.to_formatted_s(:long)).to eql 12.hours.from_now.to_formatted_s(:long)
    end
  end
  context 'checking translation of card that previously reviewed - right answer' do
    it 'increases review_date to 2.weeks.from_now' do
      card.update_attribute(:box, 3)
      fill_in(:translation, with: 'picture')
      click_button('Проверить')
      card.reload
      expect(card.review_date.to_date).to eql 2.weeks.from_now.to_date
    end
  end
  context 'checking translation of card that previously reviewed - wrong answer' do
    it 'decreases review_date to 3.days.from_now after 3 wrong guesses' do
      card.update_attribute(:box, 3)
      4.times do
        fill_in(:translation, with: 'wrong')
        click_button('Проверить')
        card.reload
      end
      expect(card.review_date.to_date).to eql 3.days.from_now.to_date
    end
  end
  context 'checking translation of card that previously reviewed - wrong answer' do
    it 'does not change review_date after 1 wrong guess' do
      card.update_attribute(:box, 3)
      fill_in(:translation, with: 'wrong')
      click_button('Проверить')
      card.reload
      expect(card.review_date.to_date).to eql Date.today
    end
  end
end
