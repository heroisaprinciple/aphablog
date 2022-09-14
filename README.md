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

<h1> Rails syntax </h1>

When you want to **display data**, use `<%= %>`

When you **don't want to display data, just code**, use `<% %>`

Ex: 

    <% @article.each do |article| %>

    <tr>
        <td class="title"> <%= article.title %></td>
    
        <td class="desc"> <%= article.description %></td>
    </tr>
    <% end %>


<h1> Working with DB </h1>

<h2>CRUD</h2>

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

**THIS IS GOOD** But, a preferable way to create a record is by making an 
instance of the class. 
`article = Article.new`

Right now the article is full of nil:  
`#<Article:0x000001f0b685c2c8 id: nil, title: nil, description: nil, created_at: nil, updated_at: nil>`
But we can fill the fields like:   `article.title = 'The second article'` and 
`article.description = 'The info about the second article'`

So, the result is `#<Article:0x000001f0b685c2c8 id: nil, title: "The second article", description: "The info about the second article", created_at: nil, updated_at: ni
l>`

Id is still nil. This shows us that that article is not IN THE DB TABLE.
Once it is in the db table, id is filled automatically.
Save it by `article.save!`
Thus, the SQL transaction is created and the 2nd article is in the db now.
Use `Article.all` to see all articles.

And we use can use constructor: `Article.new(title: 'Third article', description: 'The info about the 3rd article')`
and then save to db `article.save!`

_____
**READ AND UPDATE A RECORD**

Let's find a record: `Article.find(index)` and find an element with index 2.

Display the first article: `Article.first` and the last article: `Article.last`.
It is also much better to USE INSTANCE OF THE CLASS.

To update an article we use the instance of the class and a record field.
In essence, let's change the third article.
First, find it by `article = Article.find(3)`. Then, update it by `article.description = 'hehehehehehe`.
Save it to the database: `article.save!`.

______
**DELETE A RECORD**

Let's destroy the third article by `article.destroy`. The article is returned, but when you enter `Article.all`, there is
no article 3. There is no need to save anything.

<h2> Validation of records </h2>
By now, we can save empty records. This is not okay. There are no restrictions in article.rb file,
so we'll create them. First, we'll make sure that title of the article is necessary to fill in by

`validates :title, presence: true` in the Article class in article.rb. 
To save these changes to the model, use `reload!`
So, when we'll try to create an article without a title by `article = Article.new` and use `article.save`, `false` will be returned.
To see an error: `article.errors.full_messages`. ["Title can't be blank"] is returned.
<h3>But we'll see the error only when we save the entity to db or we validate it by`article.valid?` </h3>

Let's go further and validate description. Write `validates :description, presence: true` in the Article class.
We can also specify the length of the field by using `length: {mimimum: , maximum: }`
To save these changes to the model, use `reload!`

**To see other validation methods, use** https://guides.rubyonrails.org/active_record_validations.html

<h1>Route, action, view</h1>

<h3>When a request is made from the browser, which part of the rails application receives this request?

The router receives the request and routes it!</h3>

By writing `resources :articles` in routes.rb file and using `rails routes --expanded` in the 
console (an ordinary console, not rails), we'll see all routes and controllers in console.

Don't forget to specify exactly your URI, bec when using `resources :articles`, Rails create
a whole bunch of unnecessary routes, so, use `resources :articles, only: [:..., :...]` to
specify what routes will be used in your application.

`resources :articles, only: [:show, :index, :new, :create, :edit, :update, :destroy]` =>

1. `/articles` to show all articles

2. `/articles/1` to show the first article

3. `/articles/new` to create a new article

4. `/articles/1/edit` to update a first article

5. `/articles/1` to destroy a first article

We can render the new article to the page. But this is only render, it is not
saved in the db.
When creating a new article, nothing might happen and a new article is not saved.
This is because we don't render it in `create` method in Articles controller. 
By using `render plain: params[:article]`, we'll specify what is going to be rendered: a new article.
So, on `'/articles'`, a new article will be returned: `{"title"=>"eweqweqwe", "description"=>"qweqeqweqwewqe"}`
**But, it only renders by the browser, the new article is NOT saved yet**.

Sometimes, we might encounter a problem with turbo. 
I had a problem with rendering a new article. It didn't return a new article.
The solution for it is to add `data: { turbo: false }` in the form.
The form in in new.html.erb file.

To save to db, we need to use following in the articles controller:

`:article` is our db model

`@article = Article.new(params.require(:article).permit(:id, :title, :description))`

`@article.save!`

`redirect_to article_path(@article)`

Thus, we'll create a new article object from params, which permits fields. 
To redirect to /articles/id, use `rails routes --expanded`, find `/articles/:id` URI and method GET
PREFIX here is to access: `article` (which is a prefix)`_path` (which means path), rails will 
extract `id` from `@article` class instance. 

______________________________________________________________________

**EDIT AN ARTICLE**

Let's see what `/articles/:id/edit` has. It is an error page, saying there is
no template for this page. Let's create `edit.html.rb` then. We want to update
the article, so we need the form to do this. 
But it is not the form to create. In case of editing form, we want to display all existing info about the
article. 
Why using `@article` instance, not the particular model? We want to show info about the particular 
article and change the info of a particular info.

We still have a problem. `undefined method errors for nil:NilClass`
This is because `@article` is not instantiated yet. 

We'll instantiate the model in edit method: `@article = Article.find(params[:id])`.
So, we'll want to update the twelfth article: `/article/12/edit`, update it, 
then, click on the button. Nothing happens. Why? Fill `update` action.

Then, we'll update it (means update in db) by finding a particular article, updating it
and redirecting to the `/article/:id` in `update` method.

_______________________________________________

**DELETING AN ARTICLE**

We'll have a link, which if clicked, the entity will be deleted.
Look at `index.html.erb` file. We'll embed the link:
`<%= link_to 'Delete', 
article_path(article.id), data: {
turbo_method: :delete,
turbo_confirm: "Are you sure?"
} %>`

**Notice that without `turbo_method` and `turbo_confirm` the entity won't be deleted.**
`method: :delete` really doesn't work. 
It needs to be `turbo_method: :delete` if you are using Rails default stack. 

See https://guides.rubyonrails.org/getting_started.html#deleting-an-article


We'll delete the entity, which is found by 
`Article.find(params[:id])`.

Then, we'll redirect to our main page, which is `/articles`. 

<h1>Refactoring</h1>

We can extract some parts of code in .erb files as they look nasty.
We can do this by creating partials folder and extracting 
some code in the files there. In order Rails to understand that
this is a partial file, use _ in the name. 

___________________
<h1>Setting up associations</h1>

**Rails supports six types of associations:**

belongs_to

has_one

has_many

has_many :through

has_one :through

has_and_belongs_to_many

<h2>One-to-many association</h2>

1) The first step we' ll be doing is adding a new
column to articles table `user_id` in a new migration file:
   `add_column :articles, :user_id, :integer`.

    So, when we run `Article.all` in rails console after
`rails db:migrate`, all our entities will have a user_id field.


2) We'll add `has_many :articles` in User model and
`belongs_to :user` in Article model.

To test it: when entering `user1.articles` in rails console,
we get 
`SELECT "articles".* FROM "articles" WHERE "articles"."user_id" = ?  [["user_id", 1]]
=> []`

Let's create a new article for the first user in rails console by:
`user1.articles.build(title: 'hey man nice shot', description: 'the Rolling Stones great hits')`, so
when we enter `user1.articles`, the created rolling stones article will appear.

Let's consider that `article` is a first article and  `articleLast` is the last article.

`user2.articles << article`
and `user2.articles << articleLast`

Thus, the array of elements will be returned: [ <el with id 1>, <el with id 25> ]

But now when we run the server, we wouldn't edit the article (except the article connected with the user).
This is because now to update an article we need a `user_id`.

<h1> NEVER DO ROLLBACK TO YOUR DB. CREATE A NEW MIGRATION
FILE AND USE `add_column` IF YOU NEED TO MAKE A NEW COLUMN FOR A 
PARTICULAR TABLE.</h1>

**To reload the console, use:** `reload!`

Remember that every our article now needs a user_id to update? Good.
We also need a user_id to create an article. 
Let's go to Article controller and write `@article.user_id = Article.first.user_id`
in Create action. This is for our first article. Other articles we'll be assigned to the user through 
rails console: `Article.update_all(user_id: User.first.id)`
Now, all articles are assigned to the first user in our User table and all of them have `user_id` of 4.

To dynamically show all the users, code `by <%= article.user.username %>`
in the .each loop in the index.html.

_________________
We also should be sure about our email validation.
Let's add `before_save { self.email = email.downcase }` in our User model.
`self` means every user object, being created.
So, if we enter user's email 'JoHn@gmail.com', and then enter `.save!` in 
the rails console, the email will be automatically changed to 'john@gmail.org'.

<h1>Adding Secure Password</h1>

**As it is known, ordinary passwords are not saved into db.
They are saved in the hash format. The hash variant is always
stable. And a hacker can hack the db and get a hash variant. 
So, in order to keep your password save, the salt is added.
Salt is a piece of a random data, so every time the password
of a new user runs through hashing algorithm, the salt is added.**

1) Let's create a new migration, called `add_password_digest_to_users`.
2) In the migration file, use `add_column :users, :password_digest, :string`.
3) When we run migration and open the rails console and enter `User.all`, we'll see
that every user has a `password_digest` field, which is `nil` now.
4) Add `has_secure_password` field to User model.
5) Run `my_password = BCrypt::Password.create("kekekek")` in the console and
then, the hashed version of a password will appear. If we run again, the 
hash would be kind of different. This happens because of salt.
6) To see the salt of the hash password, use `my_password.salt`.
7) Let's add the ordinary password to our last user (it will be hashed anyway) by
`lastUser.password_digest = 'smth'` and run `lastUser.save!`. The password is saved and hashed.

_________________
<h1>New user signup form</h1>

Let's go to routes and add there `get 'signup', to: 'users#new' `.
Then, generate controller and a view.
In the view, 'users/new', we'll create a form to create a new user. 
Using `email_field` allows us to check an email field.
In essence, if we use an inappropriate email, then the error appears.

![emailValidationInForm](https://i.imgur.com/CGtT5WW.png)

And we can fill the form, but there'll be an error cause no `create` method is used in
controller yet.
To see the `params` of your hashed data, use `params` in `binding.break` console.

<h1>Editing exising users</h1>

To see all `/edit` routes (a specific routes), use `rails routes --expanded | grep edit`.
![editRoutes](https://i.imgur.com/0dHqTFg.png)

We need `/users/:id/edit(.:format)`. We'll create `edit` and `update` methods.

As we are in a different branch, we'll use:

``


















    






































