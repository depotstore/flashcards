FactoryGirl.define do
  factory :user do
    email "user1@example.com"
    password "123"
    password_confirmation { password }
  end
end
