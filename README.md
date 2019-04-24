# Little Shop

This is a student project from Turing School of Software & Design as part of the Module 2 backend engineering curriculum.  The purpose of this project was to build a fictitious e-commerce platform.
- Registered users can register to place items into a shopping cart and 'check out'
- Merchant users can mark their items as 'fulfilled'; the last merchant to mark items in an order as 'fulfilled' will automatically set the order status to "shipped"
- Each user role has access to some or all CRUD functionality for application models.

- View it live [here](https://intense-crag-12421.herokuapp.com/)  
- View the original assignment [here](https://github.com/turingschool-projects/little_shop_v2)


## Contributors
- [Blake Enyart](https://github.com/blake-enyart)
- [Matt Levy](https://github.com/milevy1)
- [Michael Karnes](https://github.com/mikekarnes123)
- [Noah Flint](https://github.com/n-flint)
- [Rene Casco](https://github.com/renecasco)

## Built With

* [Rails 5.1.7](http://sinatrarb.com/) - Web Framework
* [PostgreSQL 11.1](https://postgresapp.com/) - Database Management System


### Installing

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

- From your terminal, clone the repo: ```git clone git@github.com:blake-enyart/little-coffee-shop.git```
- If you do not have PostgreSQL, follow the steps to setup PostgreSQL [here](https://postgresapp.com/)
- Move to the new project directory: ```cd little-coffe-shop```
- Install required gems by running: ```bundle install```
- Setup the database by running: ```rake db:{drop,create,migrate,seed}```
- Start up your local Sinatra server by running: ```rails server```
- View the application in your browser ```http://localhost:3000```


### Testing

RSpec was used for testing with gems Capybara and Shoulda-matchers.  Test coverage was tracked with SimpleCov.

- To run tests, from the root directory, run: ```rspec```


### Break down of tests

Tests in the spec/features folder test features simulating user interaction with the application and then expecting content on the page within specific CSS selectors.

Tests in the spec/models folder test the object models setup in the database.  They contain validations for table attributes, table relationships, and also methods built with ActiveRecord to interact with the database.
