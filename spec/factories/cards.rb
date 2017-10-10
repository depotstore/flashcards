FactoryGirl.define do
  factory :card do
    original_text 'picture'
    translated_text 'картинка'
    review_date Date.today
    user
  end

  factory :wrong_card, class: Card do
    original_text 'test'
    translated_text 'test'
    review_date 3.days.from_now
  end
end
