require 'nokogiri'
require 'open-uri'

address = 'http://1000mostcommonwords.com/1000-most-common-russian-words/'
page = Nokogiri::HTML(open(address))
rows = page.css('#post-162 > div > table > tbody > tr')
rows.shift

rows.each do |e|
  card = Card.create!(original_text: e.css('td')[2].content,
                      translated_text: e.css('td')[1].content,
                      review_date: 3.days.from_now)
  random_date = rand(-3..3).days.from_now
  card.update_attribute(:review_date, random_date)
  puts card.inspect
end
