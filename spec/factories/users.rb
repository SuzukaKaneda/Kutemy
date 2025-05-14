FactoryBot.define do
  factory :user do
    name { "user" }
    sequence(:email) { |n| "test_#{n}@example.com" }
    sequence(:password) { |n| "password#{n}" }
  end
end
