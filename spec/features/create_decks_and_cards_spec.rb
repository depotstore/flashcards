require 'rails_helper'

describe 'creating decks and cards' do
  let!(:user) { create(:user) }
  before(:each) do
    login(user.email, '123', 'en')
    visit root_path
  end

  context 'creating card (no deck)' do
    it 'can not create card without deck' do
      click_link 'Add a card'
      expect(page).not_to have_button('Create flashcard')
    end
  end

  context 'creating deck' do
    before(:each) do
      click_link 'Decks'
      click_link 'New Deck'
      fill_in('deck[name]', with: 'deck_1')
    end
    it 'creates deck' do
      expect { click_button('Create Deck') }.to change(Deck, :count).by(1)
    end
    it 'shows deck on index' do
      click_button 'Create Deck'
      visit decks_path(locale: 'en')
      expect(page).to have_content('deck_1')
    end
  end

  context 'creating card (no current deck)' do
    before(:each) do
      visit new_deck_path(locale: 'en')
      fill_in('deck[name]', with: 'deck_1')
    end
    it 'can not create card if deck is not current' do
      click_button 'Create Deck'
      click_link 'Add a card'
      expect(page).not_to have_button('Create Card')
    end
    it 'can create card if deck is current' do
      click_button 'Create Deck'
      visit decks_path(locale: 'en')
      select('deck_1', from: :current_deck_id)
      click_button 'select deck'
      click_link 'Add a card'
      expect(page).to have_button('Create Card')
    end
  end
end
