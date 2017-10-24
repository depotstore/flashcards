require 'nokogiri'
require 'open-uri'

address = 'http://1000mostcommonwords.com/1000-most-common-russian-words/'
page = Nokogiri::HTML(open(address))
rows = page.css('#post-162 > div > table > tbody > tr')
rows.shift
password = '123'
users = %w[user1@mail.com user2@mail.com].map do |email|
            User.create!(email: email,
                         password: password,
                         password_confirmation: password)
        end
# users[0] doesn't have any card
# users[1] has 1000 cards in 3 decks and with different review date
decks = (1..3).map { |i| users[1].decks.create(name: "deck_#{i}") }
rows.each do |e|
  card = decks[rand(0..2)].cards.create!(original_text: e.css('td')[2].content,
                                translated_text: e.css('td')[1].content)
  random_date = rand(-3..3).days.from_now
  card.update_attribute(:review_date, random_date)
  puts card.inspect
end
