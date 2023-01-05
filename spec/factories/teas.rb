FactoryBot.define do
  factory :tea do
    title { Faker::Tea.variety }
    description { Faker::Coffee.notes }
    temperature { Faker::Number.within(range: 85..130) }
    brew_time { Faker::Number.within(range: 1..10) }
    price { Faker::Number.within(range: 6.99..20.99).round(2) }
  end
end
