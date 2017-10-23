require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#assign_current_deck' do
    let!(:user) { create(:user) }
    let!(:deck) { create(:deck, user: user) }
    context 'check box is checked' do
      it 'assigns current deck (checked = 1)' do
        user.assign_current_deck('1', deck)
        expect(user.current_deck_id).to eql deck.id
      end
      it 'assigns current deck (checked = on)' do
        user.assign_current_deck('on', deck)
        expect(user.current_deck_id).to eql deck.id
      end
    end
    context 'check box is unchecked' do
      it 'assigns current deck to nil' do
        user.assign_current_deck('0', deck)
        expect(user.current_deck_id).to be nil
      end
    end
  end
end
