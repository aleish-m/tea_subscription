FactoryBot.define do
  factory :subscription do
    title { Faker::Fantasy::Tolkien.poem }
    status { rand(0..1) }
    frequency { rand(1..12) }
    user
  end
end
