require 'rails_helper'

describe 'user signup english' do
  let(:user) { build(:user) }

  before(:each) do
    visit signup_path(locale: 'en')
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: '123'
    fill_in 'user[password_confirmation]', with: '123'
    select('en', from: 'user[language]')
    click_button 'Sign Up'
  end

  it 'gets informed about account creation' do
    expect(page).to have_content 'Account was successfully created.'
  end

  context 'after signup user is logged in' do
    it 'has access to check translation' do
      expect(page).to have_content 'No cards for reivew.'
    end

    it 'has access to all cards' do
      click_link 'All cards'
      expect(page).to have_content('All cards', count: 2)
    end

    it 'has access to edit profile' do
      click_link 'Edit Profile'
      expect(page).to have_content('Edit Profile', count: 2)
    end
  end
end
