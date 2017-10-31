# Securing Passwords

## Objectives
1. Learn about bcrypt, a gem that works to encrypt passwords.
2. Learn about Active Record's `has_secure_password` method.
3. Sign up and log in a user with a secure, encrypted password.

## Overview
Securing users' data is one of the most important jobs of a web developer. Despite frequent warnings against it, many of your users will use the same username and password combination across many different websites. This means that, in general, people will use the same password for our applications that they do for their bank.

Because of this, we never want to store our users' passwords in plain text in our database. Instead, we'll run the passwords through a hashing algorithm. A hashing algorithm manipulates data in such a way that it cannot be un-manipulated. This is to say that if someone got a hold of the hashed version of a password, they would have no way to turn it back into the original. In addition to hashing the password, we'll also add a "salt". A salt is simply a random string of characters that gets added into the hash. That way, if two of our users use the password "fido", they will end up with different hashes in our database.

We'll use an open-source gem, `bcrypt`, to implement this strategy.

## Starter Code
We've got a basic Sinatra MVC application. In our `application_controller` we have two helper methods defined: `logged_in?` returns true or false based on the presence of a `session[:user_id]`, and `current_user` returns the instance of the logged in user, based on the `session[:user_id]`. We have five actions defined:

+ `get "/" do` renders an `index.erb` file with links to signup or login.
+ `get '/signup'` renders a form to create a new user. The form includes fields for `username` and `password`.
+ `get '/login'` renders a form for logging in.
+ `get '/success'` renders a `success.erb` page, which should be displayed once a user successfully logs in.
+ `get '/failure'` renders a `failure.erb` page. This will be accessed if there is an error logging in or signing up.
+ `get '/logout'` clears the session data and redirects to the homepage.

We've also stubbed out a user model in `app/models/user.rb` that inherits from `ActiveRecord::Base`.

Fork and clone this repository and run `bundle install` to get started!

## Password Encryption with BCrypt
BCrypt will store a salted, hashed version of our users' passwords in our database in a column called `password_digest`. Essentially, once a password is salted and hashed, there is no way for anyone to decode it. This method requires that hackers use a 'brute force' approach to gain access to someone's account –– still possible, but more difficult.

### Implementing BCrypt
We've created a migration file for you (using `rake db:create_migration
NAME=create_users`), but you'll need to fill it in. Let's edit that file so that
it actually creates a `users` table. We'll have two columns: one for `username`
and one for `password_digest`.

```ruby
class CreateUsers < ActiveRecord::Migration
	def up
		create_table :users do |t|
			t.string :username
			t.string :password_digest
		end
	end

	def down
		drop_table :users
	end
end
```

Run this migration using `rake db:migrate`. Preview your work by running `shotgun` and navigating to [localhost:9393](http://localhost:9393/) in your browser. Awesome job!

***NOTE***: If you're in the Learn IDE, instead of going to [localhost:9393](http://localhost:9393/) you'll navigate to the URL output by the `shotgun` command.

### ActiveRecord's `has_secure_password`
Next, let's update our user model so that it includes `has_secure_password`. This ActiveRecord macro gives us access to a few new methods. A macro is a method that when called, creates methods for you. This is meta programming, which you don't need to worry about now. Just know that using a macro is just like calling a normal ruby method.

In this case, the macro `has_secure_password` is being called just like a normal ruby method. It works in conjunction with a gem called `bcrypt` and gives us all of those abilities in a secure way that doesn't actually store the plain text password in the database.

```ruby
class User < ActiveRecord::Base
	has_secure_password
end
```

Next, let's handle signing up. In our `post '/signup'` action, let's make a new instance of our user class with a username and password from params. Note that even though our database has a column called `password_digest`, we still access the attribute of `password`. This is given to us by `has_secure_password`. You can read more about that in the [Ruby Docs](http://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html#method-i-has_secure_password).

```ruby
post "/signup" do
	user = User.new(:username => params[:username], :password => params[:password])
end
```

Because our user has `has_secure_password`, we won't be able to save this to the database unless our user filled out the password field. Calling `user.save` will return false if the user can't be persisted. Let's update this route so that we redirect to `'/login'` if the user is saved, or `'/failure'` if the user can't be saved. (For now, we'll make the user log in after they sign up successfully).

```ruby
post "/signup" do
	user = User.new(:username => params[:username], :password => params[:password])

	if user.save
		redirect "/login"
	else
		redirect "/failure"
	end
end
```

Awesome! Test this feature out in your browser. Leaving the password field blank should land you at the "failure" page, while creating a valid user should take you to login.

Next, create at least one valid user, then let's build out our login action. In `post '/login'`, let's find the user by username.

```ruby
post "/login" do
	user = User.find_by(:username => params[:username])
end
```

Next, we need to check two conditions: first, did we find a user with that username? This can be written as `user != nil` or simply `user`.

```ruby
post "/login" do
	user = User.find_by(:username => params[:username])
	if user
		redirect "/success"
	else
		redirect "/failure"
	end
end
```

We also need to check if that user's password matches up with the value in `password_digest`. We can use a method called `authenticate`. The method is provided for us by the bcrypt gem. Our `authenticate` method takes a string as an argument. If the string matches up against the password digest, it will return the user object, otherwise it will return false. Therefore, we can check that we have a user AND that the user is authenticated. If so, we'll set the `session[:user_id]` and redirect to the `/success` route. Otherwise, we'll redirect to the `/failure` route so our user can try again.


```ruby
post "/login" do
	user = User.find_by(:username => params[:username])

	if user && user.authenticate(params[:password])
		session[:user_id] = user.id
		redirect "/success"
	else
		redirect "/failure"
	end
end
```

Awesome job! We've now built out a basic authentication system for a user without storing a plain-text password in our database.

## Video Review
* [Authentication](https://www.youtube.com/watch?v=_S1s6R-_wYc)

## Resources
+ [BCrypt Ruby](https://github.com/codahale/bcrypt-ruby)
+ [Intro to BCrypt & Password Security](https://www.youtube.com/watch?v=O6cmuiTBZVs) - MakerSquare on YouTube
+ [Ruby on Rails Guide: Has Secure Password](http://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html)
+ [How NOT to Store Passwords!](https://www.youtube.com/watch?v=8ZtInClXe1Q) - Computerphile on Youtube

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/sinatra-password-security'>Securing Passwords in Sinatra</a> on Learn.co and start learning to code for free.</p>
