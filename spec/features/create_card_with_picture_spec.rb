require "rails_helper"

describe 'creating card with picture' do
  let!(:user) { create(:user) }
  let!(:deck) { create(:deck, user: user) }

  before(:each) do
    login(user.email, '123', 'en')
    user.assign_current_deck(deck.id)
    click_link 'Add a card'
    fill_in('card[original_text]', with: 'test')
    fill_in('card[translated_text]', with: 'тест')
  end

  context 'uploading picture by url' do
    before(:each) do
      picture_url = 'https://amazonbucketcde.s3.amazonaws.com/uploads/card/picture/1002/rectangle.png'
      fill_in('card[remote_picture_url]', with: picture_url)
    end

    it 'has notification' do
      click_button 'Create Card'
      expect(page).to have_content 'Card created'
    end

    it 'creates card' do
      expect { click_button 'Create Card' }.to change(Card, :count).by(1)
    end

    it 'has picture' do
      click_button 'Create Card'
      expect(page.find('img')['src']).to have_content 'rectangle.png'
    end
  end

  context 'uploading picture by attaching file' do
    before(:each) do
      attach_file 'card[picture]', Rails.root + "app/assets/images/square.png"
    end

    it 'has notification' do
      click_button 'Create Card'
      expect(page).to have_content 'Card created'
    end

    it 'creates card' do
      expect { click_button 'Create Card' }.to change(Card, :count).by(1)
    end

    it 'has picture' do
      click_button 'Create Card'
      expect(page.find('img')['src']).to have_content 'square.png'
    end
  end
end
