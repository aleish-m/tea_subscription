# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
users = User.create([{first_name: Faker::Name.first_name,
                      last_name: Faker::Name.last_name,
                      email: Faker::Internet.safe_email,
                      address: Faker::Address.full_address
                    },
                      {first_name: Faker::Name.first_name,
                      last_name: Faker::Name.last_name,
                      email: Faker::Internet.safe_email,
                      address: Faker::Address.full_address
                    },
                      {first_name: Faker::Name.first_name,
                      last_name: Faker::Name.last_name,
                      email: Faker::Internet.safe_email,
                      address: Faker::Address.full_address
                    },
                      {first_name: Faker::Name.first_name,
                      last_name: Faker::Name.last_name,
                      email: Faker::Internet.safe_email,
                      address: Faker::Address.full_address
                    }
                      ])
teas = Tea.create([{title: Faker::Tea.variety,
                description: Faker::Coffee.notes,
                temperature: Faker::Number.within(range: 85..130),
                brew_time: Faker::Number.within(range: 1..10),
                price: Faker::Number.within(range: 6.99..20.99).round(2)
              },
                {title: Faker::Tea.variety,
                description: Faker::Coffee.notes,
                temperature: Faker::Number.within(range: 85..130),
                brew_time: Faker::Number.within(range: 1..10),
                price: Faker::Number.within(range: 6.99..20.99).round(2)
              },
                {title: Faker::Tea.variety,
                description: Faker::Coffee.notes,
                temperature: Faker::Number.within(range: 85..130),
                brew_time: Faker::Number.within(range: 1..10),
                price: Faker::Number.within(range: 6.99..20.99).round(2)
              },
                {title: Faker::Tea.variety,
                description: Faker::Coffee.notes,
                temperature: Faker::Number.within(range: 85..130),
                brew_time: Faker::Number.within(range: 1..10),
                price: Faker::Number.within(range: 6.99..20.99).round(2)
              },
                {title: Faker::Tea.variety,
                description: Faker::Coffee.notes,
                temperature: Faker::Number.within(range: 85..130),
                brew_time: Faker::Number.within(range: 1..10),
                price: Faker::Number.within(range: 6.99..20.99).round(2)
              },
                {title: Faker::Tea.variety,
                description: Faker::Coffee.notes,
                temperature: Faker::Number.within(range: 85..130),
                brew_time: Faker::Number.within(range: 1..10),
                price: Faker::Number.within(range: 6.99..20.99).round(2)
              },
                {title: Faker::Tea.variety,
                description: Faker::Coffee.notes,
                temperature: Faker::Number.within(range: 85..130),
                brew_time: Faker::Number.within(range: 1..10),
                price: Faker::Number.within(range: 6.99..20.99).round(2)
              },
                {title: Faker::Tea.variety,
                description: Faker::Coffee.notes,
                temperature: Faker::Number.within(range: 85..130),
                brew_time: Faker::Number.within(range: 1..10),
                price: Faker::Number.within(range: 6.99..20.99).round(2)
              },
                {title: Faker::Tea.variety,
                description: Faker::Coffee.notes,
                temperature: Faker::Number.within(range: 85..130),
                brew_time: Faker::Number.within(range: 1..10),
                price: Faker::Number.within(range: 6.99..20.99).round(2)
              },
                {title: Faker::Tea.variety,
                description: Faker::Coffee.notes,
                temperature: Faker::Number.within(range: 85..130),
                brew_time: Faker::Number.within(range: 1..10),
                price: Faker::Number.within(range: 6.99..20.99).round(2)
              }
                ])