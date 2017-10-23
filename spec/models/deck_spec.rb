require 'rails_helper'

RSpec.describe Deck, type: :model do
  describe '#assign_current_deck' do
    let!(:user) { create(:user) }
    let!(:deck) { create(:deck, user: user) }
    let!(:another_deck) { create(:deck, user: user) }
    context 'check box is checked' do
      it 'assigns current deck (checked = 1)' do
        deck.assign_current_deck('1')
        expect(user.current_deck_id).to eql deck.id
      end
      it 'assigns current deck (checked = on)' do
        deck.assign_current_deck('on')
        expect(user.current_deck_id).to eql deck.id
      end
    end
    context 'check box is unchecked' do
      it 'assigns current deck to nil' do
        deck.assign_current_deck('0')
        expect(user.current_deck_id).to be nil
      end
    end
    context 'another deck is current and check box of deck is unchecked' do
      it 'does not change current deck id' do
        another_deck.assign_current_deck('1')
        deck.assign_current_deck('0')
        expect(user.current_deck_id).to be another_deck.id
      end
    end
  end
end
