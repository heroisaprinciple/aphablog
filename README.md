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

______
**CREATING A RECORD**

Let's create a new table in the models folder. 
The first model is Article model. We can use it with Rails console: `rails c`
To exit from it: `exit`

We'll see all articles from the Article table by `Article.all` in rails console.
For now it is [].

To create a new record: `Article.create(title: 'first_article', description: 'Info about first article')`
The record is created. 

**THIS IS GOOD** But, a preferrable way to create a record is by making an 
instance of the class. 
`article = Article.new`

Right now the article is full of nil:  
`#<Article:0x000001f0b685c2c8 id: nil, title: nil, description: nil, created_at: nil, updated_at: nil>`
But we can fill the fields like:   `article.title = 'The second article'` and 
`article.description = 'The info about the second article'`

So, the result is `#<Article:0x000001f0b685c2c8 id: nil, title: "The second article", description: "The info about the second article", created_at: nil, updated_at: ni
l>`

Id is still nil. This shows us that that article is now IN THE DB TABLE.
Once it is in the db table, id is filled automatically.
Save it by `article.save`
Thus, the SQL transaction is created and the 2nd article is in the db now.
Use `Article.all` to see all articles.

And we use can use constructor: ` Article.new(title: 'Third article', description: 'The info about the 3rd article')`
and then save to db `article.save`
















