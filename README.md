# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


To create migration of data:
`rails generate migration [name]`
Then different files are appeared in migrate folder in db folder.

To make migration: `rails db:migrate`
After that, new fields are created in schema.rb

For updating our table (since we have only had migration), we should rollback the migration and add everything
again: `rails db:rollback` and then `rails db:migrate`

**BUT THIS IS A TERRIBLE APPROACH.**

Actually, when you work in the team, it would be much better to create
**new migration file** where a developer see every change. 

To do this, generate a new migration file by `rails generate [another_name]
` and update the column by adding timestamps. **What is good, WebStorm
generates it automatically.**






