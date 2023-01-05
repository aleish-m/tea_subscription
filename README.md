# README - Tea Subscription API Project

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
- [Create a new User Subscription](#create-a-new-user-subscription)
## End Points

### Get all Subscriptions for a User
GET `/api/v1/users/1/subscription`

JSON Contract:
```
{
    "data": [
        {
            "id": "1",
            "type": "subscription",
            "attributes": {
                "title": "New Subscription",
                "status": "active",
                "frequency": 2,
                "created_at": "2023-01-05T00:48:28.722Z",
                "price": 29.37
            }
        },
        {
            "id": "2",
            "type": "subscription",
            "attributes": {
                "title": "Winter Blues",
                "status": "active",
                "frequency": 6,
                "created_at": "2023-01-05T05:26:27.366Z",
                "price": 48.98
            }
        }
    ]
}
```

Example for invalid request:
```
{
    "error": 404,
    "message": "User must exist"
}
```

### Create a new User Subscription
POST `/api/v1/users/1/subscription`

Required Request Params:
  - title (string)
  - frequency (integer)
  - tea_ids (string of a list of id's)

Example params:
```
{ 
  title: 'New Subscription',
  tea_ids: "1, 2, 6, 10",
  frequency: 2 
}
```

JSON Response:
```
{
    "data": {
        "id": "2",
        "type": "subscription",
        "attributes": {
            "title": "New Subscription",
            "status": "active",
            "frequency": 2,
            "created_at": "2023-01-05T05:22:12.215Z",
            "price": 29.37
        }
    }
}
```

Example response if creation is unsuccessful:
```
{
    "error": 400,
    "message": [
        "Title can't be blank"
    ]
}
```

