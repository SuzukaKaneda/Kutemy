FactoryBot.define do
  factory :recipe do
    title { "料理名" }
    get_point { "2" }
    association :user
  end
end
