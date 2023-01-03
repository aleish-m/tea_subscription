FactoryBot.define do
  factory :tea do
    title { Faker::Tea.variety }
    description { Faker::Coffee.notes }
    temperature { Faker::Number.within(range: 85..130) }
    brew_time { Faker::Number.within(range: 1..10) }
    price { Faker::Number.decimal(l_digits: 2) }
  end
end
