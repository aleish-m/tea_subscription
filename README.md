# Tea Subscription API Project

## Table of Contents
- [About the Project](#about-the-project)
  - [Project Challenges](#project-challenges)
    - [Architecture](#architecture)
    - [Backend Database Design](#backend-database-design)
    - [Additional Endpoints](#additional-endpoints)
    - [Edge Caseing](#edge-caseing)
- [Built With](#built-with)
- [Setup/Install](#setupinstall)
- [Database Structure](#database-structure)
- [End Points](#end-points)
- [Developer Info](#developer-info)
---

# About the Project
 This project is a MVP Backend Application for a Tea Subscription Application. It allows for users to see all available teas then add multiple teas to a subscription with a chosen order frequency. The user is also able to view all the subscriptions they have set up and stop a subscription from continuing.

 ## Project Challenges
  - This project was left very open ended so that many design decisions had to be made along the way.
    - ### Architecture
      -  __Monothith or Service Oriented?__ - Primarily due to the time expectation (~ 8 hours) and the required deliverables, I chose to use a Service Oriented Architecture. With this decision I was able to focus the project scoop on the the planning, expected data returns, and the backend data structure rather then having to split my time between the Backend development, Frontend design, and planning. 
    - ### Backend Database Design
      - __How Many Tables? Relationships?__ - The first big design decision was how the database was going to look and relate to eachother. We were provided with 3 suggested Object Types and a few attributes for each. *(Tea, Subscription, Customer)*. I chose to stay pretty close to the suggested Objects and attributes, but with the following changes.
        - __Tables__ Based on my experience with subscriptions for Herbs/Spices and the suggestion that a Subscription would have its own unique title I decided that I wanted a Many-to-Many relationship type between subscriptions and Teas. 
          - This introduced an additional join table for my database. 
        - __Attributes__ I also decided that it made that price should be an attribute for a tea rather than a subscription. Yet, I still wanted to return a price for the subscription the factored in all teh teas in that subscription.
          - I only included price on a tea so a tea's price can easily be updated on the tea table and then created a method to calculate the cost of the subscription based on the tea's so it can change according to the current price of the tea included. 
        - __Naming__ - I chose to change the name of the suggested 'Customer' object to 'User'. While a user may be a customer I decided that since we were storing this data it is more conventional for a web application to have users that log-in and have accounts. 
          - Using 'User' as a model name is more developer friendly as it is intuitive on what type of data is likely to be stored and how to interact with the object when jumping into the codebase.
    - ### Additional Endpoints
      - We were allowed to add additional endpoints to this project if we wanted. I did select and write issues for 2 endpoints that I would have liked to build out if there was time. Due to time I did not get to build these out as hoped.
    - ### Edge Caseing
      - Rather then built out the additional planned endpoints I spent time working on some edge cases for the required endpoints. In this I found my biggest challenge. 
        - __Enum Validation__ - Up until this point I have never tried or had a need to validate that an enum value was correct and return a response accordingly. When I wrote my test for this and started down this path I expected this to function the same as a validation in rails and just not save a object due to an error. I found that this was not the case and that Rails actually errors out for an `Argument Error` and this causes a 500 server error when called in Postman. I found that most people who have written about this error have had to go to teh Parent class for this Error and override this error then tell the program what to do instead. 
          - I did not like the idea of overriding this error in teh parent class so I chose to `rescue` from this error and create a custom error message in the controller that would be sent out. This may not have been the most elegant solution but I like that it still allows Rails to Error when and as expected everywhere else and still allows me to use the functionality of an enum. 
          - I'm glad I did this as I learned this is a common problem that is faced when working with Rails for and API and testing this so the program responds correctly is important. 
          - I did find that the most recommended solution was to not use an enum and rather just use an `includes` validation unless the other enum functionality is needed. In my case I do not need this to be an enum so If I were to redo/revisit this project I would probably change this data type in my database.

[Back to Top](#table-of-contents)
# Built With
This project used `Ruby 2.7.4`

- with Rails `5.2.x`
- and used `PostgreSQL`


![RoR](https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white)
![pgsql](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)

## Gems
![rspec](https://img.shields.io/gem/v/rspec-rails?label=rspec&style=flat-square)
![jsonapi-serializer](https://img.shields.io/badge/jsonapi--serializer-v%202.2.0-green)
![shoulda](https://img.shields.io/gem/v/shoulda-matchers?label=shoulda-matchers&style=flat-square)
![simplecov](https://img.shields.io/gem/v/simplecov?label=simplecov&style=flat-square)
![factory bot](https://img.shields.io/gem/v/factory_bot_rails?color=blue&label=factory_bot_rails)
![faker](https://img.shields.io/gem/v/faker?color=blue&label=faker)
![pry](https://img.shields.io/gem/v/pry?color=blue&label=pry)

# Setup/Install

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

[Back to Top](#table-of-contents)
# Database Structure

![image](app/assets/tea_subscription_schema.png)

# End Points
## Available End Points

- ### [Get all Subscriptions for a User](#get-all-subscriptions-for-a-user)
  - [JSON Contract](#json-contract)
  - [Example for invalid request](#example-for-invalid-request)
- ### [Create a new User Subscription](#create-a-new-user-subscription)
  - [Required Request Params](#required-request-params)
  - [JSON Response](#json-response) 
  - [Example response - unsuccessful](#example-response-if-creation-is-unsuccessful)
- ### [Update Subscription](#update-a-new-users-subscription)
  - [Optional Request Params](#optional-request-params)
  - [JSON Response](#json-response-1)
  - [Example response if update is unsuccessful](#example-response-if-update-is-unsuccessful)


[Back to Top](#table-of-contents)


---

## Get all Subscriptions for a User
- GET `/api/v1/users/1/subscriptions`

### JSON Contract:
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
### Example for invalid request:
```
{
    "error": 404,
    "message": "User must exist"
}
```
[Back to End Points](#available-end-points)

## Create a new User Subscription
- POST `/api/v1/users/1/subscriptions`

### Required Request Params:
  - title (string)
  - frequency (integer)
  - tea_ids (string of a list of id's)

### Example params:
```
{ 
  title: 'New Subscription',
  tea_ids: '1, 2, 6, 10',
  frequency: 2 
}
```

### JSON Response:
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

### Example response if creation is unsuccessful:
```
{
    "error": 400,
    "message": [
        "Title can't be blank"
    ]
}
```

[Back to End Points](#available-end-points)
## Update a new User's Subscription
- POST `/api/v1/users/1/subscriptions/1`

### Optional Request Params:
  - title (string)
  - frequency (integer)
  - status

### Example Params:
```
{ 
  title: 'Updated Title',
  status: 'cancelled',
  frequency: 2 
}
```

### JSON Response:
```
{
    "data": {
        "id": "1",
        "type": "subscription",
        "attributes": {
            "title": "Updated Title",
            "status": "cancelled",
            "frequency": 2,
            "created_at": "2023-01-05T00:48:28.722Z",
            "price": 29.37
        }
    }
}
```

### Example response if update is unsuccessful:
```
{
    "error": 400,
    "message": [
        "Frequency is not a number",
        "Frequency value is not within 1-12",
        "Status can only be 'active' or 'cancelled'"
    ]
}
```

[Back to End Points](#available-end-points)

[Back to Top](#table-of-contents)
## Developer Info
<p><a href="https://github.com/aleish-m/rails-engine/graphs/contributors">
<img src="https://contrib.rocks/image?repo=aleish-m/rails-engine" />
</a></p>

**Github:** <https://github.com/aleish-m/>  
**LinkedIn:** <https://www.linkedin.com/in/aleisha-mork/>
