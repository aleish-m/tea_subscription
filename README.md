# README - Rails Engine API

## About the Project
 This project is a MVP Backend Application for a Tea Subscription Application. It allows for users to see all available teas then add multiple teas to a subscription with a chosen order frequency. The user is also able to view all the subscriptions they have set up and stop a subscription from continuing.

## Built With
This project used `Ruby 2.7.4`

- with Rails `5.2.x`
- and used `PostgreSQL`
![RoR](https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white)
![pgsql](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)

## Gems
![rspec](https://img.shields.io/gem/v/rspec-rails?label=rspec&style=flat-square)
![shoulda](https://img.shields.io/gem/v/shoulda-matchers?label=shoulda-matchers&style=flat-square)
![simplecov](https://img.shields.io/gem/v/simplecov?label=simplecov&style=flat-square)
![faker](https://img.shields.io/gem/v/faker?color=blue&label=faker)
![factory bot](https://img.shields.io/gem/v/factory_bot_rails?color=blue&label=factory_bot_rails)
![pry](https://img.shields.io/gem/v/pry?color=blue&label=pry)

## Setup/Install

- Fork this repository
- Clone your fork
- From the command line, install gems and set up your DB:
  - Run `bundle install`
  - Run `rails db:{create,migrate,seed}`
- Run the test suite with `bundle exec rspec`.
## Deployment
- In terminal (apple or integrated)
    * `rails s`
- Navigate to desired API endpoint as noted below
## Database Structure

![image](app/assets/tea_subscription_schema.png)

## Table of Contents for End Points

- [Get all Subscriptions for a User](#get-all-subscriptions-for-a-user)
## End Points

### Get all Subscriptions for a User

