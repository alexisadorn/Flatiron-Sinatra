# Secure Password Lab

## Objectives

1. Use bcrypt, a gem that works to encrypt passwords.
2. Use Active Record's `has_secure_password` method.
3. Sign up and Sign in a user with a secure, encrypted password. 

## The Challenge

You're back at Flatiron Bank, where the executive staff has been alerted that the developers who built the authentication system forgot to use password encryption. That means that all of the bank's user passwords are easily available to hackers and bad actors. The CTO has called you in to implement secure passwords in the bank's system.

Use the `bcrypt` gem, to implement this strategy.
  
## Starter Code

We've got a basic Sinatra MVC application for our bank. In our `application_controller` we have two helper methods defined; `logged_in?` returns true or false based on the presence of a `session[:user_id]` and `current_user` returns the instance of the logged in user, based on the `session[:user_id]`.

We have five actions defined: 

+ `get "/" do` renders an `index.erb` file with links to signup or login. 
+ `get '/signup'` renders a form to create a new user. The form includes fields for `username` and `password`. 
+ `get '/login'` renders a form for logging in.
+ `get '/account'` renders an `account.erb` page, which should be displayed once a user successfully logs in.
+ `get '/failure'` renders a `failure.erb` page. This will be accessed if there is an error logging in or signing up. 
+ `get '/logout'` clears the session data and redirects to the home page.

The **Helper Methods** at the bottom of the controller are part of Sinatra's configurations for helper methods. These are methods that allow us to add logic to our views. Views automatically have access to all helper methods thanks to Sinatra.

We've also stubbed out a user model in `app/models/user.rb` which inherits from `ActiveRecord::Base`. 

Fork and clone this repository and run `bundle install` to get started. Preview your work by running `shotgun` and navigating to http://localhost:9393 in your browser. 

## To Do
Get the tests to pass. You'll need to use 'bcrypt' to salt your password and make sure that it is encrypted.

You'll also need to create a users table. A user should have a username and password.

## Bonus

Add a migration that gives the user model a balance (should start for any user at $0), and add functionality on the account page to make deposits and withdrawals. A user should never be able to withdraw more money than they have in their account.

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/sinatra-secure-password-lab' title='Secure Password Lab'>Secure Password Lab</a> on Learn.co and start learning to code for free.</p>
