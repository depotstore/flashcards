require 'rails_helper'

RSpec.describe Card, type: :model do

  subject(:card){ FactoryGirl.build(:card) }

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

  describe '#arrange_review_date' do
    it 'arranges date 3 days from now' do
      card.arrange_review_date
      expect(card.review_date.utc.to_s).to eql(3.day.from_now.to_s)
    end
  end

  describe '#not_the_same' do
    let(:wrong_card){ FactoryGirl.build(:wrong_card) }
    context 'when original and translated text are the same'
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
