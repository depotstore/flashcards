require 'rails_helper'

describe 'user registration' do
  let(:user) { build(:user) }

  before(:each) do
    visit '/register'
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: '123'
    fill_in 'user[password_confirmation]', with: '123'
    click_button 'Submit'
  end

  it 'gets informed about account creation' do
    expect(page).to have_content 'Account was successfully created.'
  end

  context 'after registration user is logged in' do
    it 'has access to check translation' do
      visit root_path
      expect(page).to have_content 'No cards for reivew.'
    end

    it 'has access to all cards' do
      visit root_path
      click_link 'Все карточки'
      expect(page).to have_content('Все карточки', count: 2)
    end

    it 'has access to edit profile' do
      click_link 'Edit Profile'
      expect(page).to have_content('Edit Profile', count: 2)
    end
  end
end
