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
