require 'rails_helper'

RSpec.describe Card, type: :model do

  subject(:card) { build(:card) }

  describe '#check_translation' do
    context 'when translation is correct' do
      it 'returns true' do
        expect(card.check_translation('picture')).to be true
      end
    end
    context 'when translation is not correct' do
      it 'returns false' do
        expect(card.check_translation('wrong')).to be false
      end
    end
  end

  describe '#not_the_same' do
    let(:wrong_card) { build(:wrong_card) }
    context 'when original and translated text are the same' do
      it 'returns error message' do
        expect(wrong_card.not_the_same[0]).to eql("and translated text shouldn't be equal.")
      end
    end
    context 'when original and translated text are different' do
      it 'returns nil' do
        expect(card.not_the_same).to be nil
      end
    end
  end

  describe '#wrong_guess_counter' do
    let!(:user) { create(:user) }
    let!(:deck) { create(:deck, user: user) }
    let!(:card) { create(:card, deck: deck) }
    it 'increases wrong guess value' do
      3.times { card.wrong_guess_counter }
      expect(card.wrong_guess).to eql(3)
    end
  end

  describe '#arrange_review_date (forward review_date)' do
    let!(:user) { create(:user) }
    let!(:deck) { create(:deck, user: user) }
    let!(:card) { create(:card, deck: deck) }
    before(:each) do
      card.update_attribute(:box, 2)
    end
    it 'increases box number' do
      card.arrange_review_date(1)
      expect(card.box).to eql(3)
    end
    it 'forward review date' do
      card.arrange_review_date(1)
      expect(card.review_date.to_date).to eql(1.week.from_now.to_date)
    end
    it 'assigns box number not greater than 5' do
      card.update_attribute(:box, 5)
      card.arrange_review_date(1)
      expect(card.box).to eql(5)
    end
    it 'assigns review date not greater than 1.month.from_now' do
      card.update_attribute(:box, 5)
      card.arrange_review_date(1)
      expect(card.review_date.to_date).to eql(1.month.from_now.to_date)
    end
  end

  describe '#arrange_review_date (backward review_date)' do
    let!(:user) { create(:user) }
    let!(:deck) { create(:deck, user: user) }
    let!(:card) { create(:card, deck: deck) }
    before(:each) do
      card.update_attribute(:box, 3)
    end
    it 'decreases box number' do
      card.arrange_review_date(-1)
      expect(card.box).to eql(2)
    end
    it 'backward review date' do
      card.arrange_review_date(-1)
      expect(card.review_date.to_date).to eql(3.days.from_now.to_date)
    end
    it 'nullifies wrong guess' do
      card.arrange_review_date(-1)
      expect(card.wrong_guess).to eql(0)
    end
    it 'assigns box number not less than 1' do
      card.update_attribute(:box, 1)
      card.arrange_review_date(-1)
      expect(card.box).to eql(1)
    end
    it 'assigns review date not less than 12.hours.from_now' do
      card.update_attribute(:box, 1)
      card.arrange_review_date(-1)
      expect(card.review_date.to_formatted_s(:long)).to eql(12.hours.from_now.to_formatted_s(:long))
    end
  end
  describe '#typo?' do
    let!(:user) { create(:user) }
    let!(:deck) { create(:deck, user: user) }
    let!(:card) { create(:card, deck: deck) }
    it 'returns true if typo' do
      expect(card.typo?('pictuer')).to be true
    end
    it 'returns false if wrong answer' do
      expect(card.typo?('wrong')).to be false
    end
  end
end
