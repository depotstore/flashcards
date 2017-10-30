module LoginHelper
  def login(email, password, language)
    visit root_path
    click_link language
    fill_in :email, with: email
    fill_in :password, with: password
    language.eql?('en') ? click_button('Login') : click_button('Войти')
  end
end

RSpec.configure do |c|
  c.include LoginHelper
end
