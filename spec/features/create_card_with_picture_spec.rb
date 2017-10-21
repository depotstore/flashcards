require "rails_helper"

describe 'creating card with picture' do
  let!(:user) { create(:user) }
  let!(:deck) { create(:deck, user: user, current: true) }

  context 'uploading picture by url' do
    before(:each) do
      login(user.email, '123')
      click_link 'Добавить карточку'
      fill_in('card[original_text]', with: 'test')
      fill_in('card[translated_text]', with: 'тест')
      picture_url = 'https://amazonbucketcde.s3.amazonaws.com/uploads/card/picture/1002/rectangle.png'
      fill_in('card[remote_picture_url]', with: picture_url)
    end

    it 'has notification' do
      click_button 'Create flashcard'
      expect(page).to have_content 'Card created.'
    end

    it 'creates card' do
      expect { click_button 'Create flashcard' }.to change(Card, :count).by(1)
    end

    it 'has picture' do
      click_button 'Create flashcard'
      expect(page.find('img')['src']).to have_content 'rectangle.png'
    end
  end

  context 'uploading picture by attaching file' do
    before(:each) do
      login(user.email, '123')
      click_link 'Добавить карточку'
      fill_in('card[original_text]', with: 'test')
      fill_in('card[translated_text]', with: 'тест')
      attach_file 'card[picture]', Rails.root + "app/assets/images/square.png"
    end

    it 'has notification' do
      click_button 'Create flashcard'
      expect(page).to have_content 'Card created.'
    end

    it 'creates card' do
      expect { click_button 'Create flashcard' }.to change(Card, :count).by(1)
    end

    it 'has picture' do
      click_button 'Create flashcard'
      expect(page.find('img')['src']).to have_content 'square.png'
    end
  end
end
