# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- Ruby version: "3.2.2"
  
- Rails Version: 7.1.3
  
- Configuration
  Database Configuration(Basic of localhost) - Add below 4 line below require environment as shown.
  
  development: #environment
  <<: *default
  database: REQUIRED_DB_NAME
  username: REQUIRED_USER_NAME
  password: REQUIRED_PASSWORD
  host: localhost
  
- Database creation
  rails db:create

- How to run the application
  bundle install  #to install the gems/ update the gems
  rails db:migrate  #to run the migrations
  rails s #to start the server
  

