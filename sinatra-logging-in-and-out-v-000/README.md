# Sinatra Sessions Lab - User Logins

## Introduction

You've been contracted by Flatiron Bank to consult on their online banking application. Specifically, they've asked you to build out their user login process. Based on your knowledge of sessions, build out the log in and log out features, and ensure that users that log in can only see their own balance.

## Helper Methods

MVC architecture relies heavily on the principle of separation of concerns. We make sure that we have a different model for every class we build, that we only have one erb file per view, etc. This even extends to the purposes each of these files has. A model handles our Ruby logic, our controllers handle the HTTP requests and connect to our models, and our views either take in or display data to our users.

This means that we want to minimize the amount of logic our views contain. Our views should never directly pull from the database (ie. `User.all`, etc). All of that should be taken care of in the controller actions, and the data should be passed to the view via a specific controller action.

But if you think about most web applications you use, there is information on most pages that is dependent on being logged in. You can see a lot of information if you are logged in and practically none if you're not. So how can you handle that sort of application flow without logic?

Instead of writing that type of logic directly into a view, we use helper methods. Helper methods are methods that are written in the controller, are accessible in the views, and provide some logical support. But a helper method is just a regular method, defined using `def` and `end` just like you've always done.

In the `app/helpers` directory, we're going to define a separate class specifically designed to control logic in our views. This `Helpers` class will have two class methods, `current_user` and `is_logged_in?`.

These two methods will only ever be called in views, particularly `account.erb`, in order to add double protection to this view so that only the current user, when they are logged in, can see their bank account balance.

It's important to note that helper methods can be used for a lot more than just tracking whether a user is logged in and who the current user is. Helpers are methods that make it cleaner to add logic to our views.

## Instructions

+ You'll want to create a User class and a table to store users. Users should have a username, password, and balance (a decimal storing their bank account balance).

+ You'll need to create a login form on the index page that accepts a username and password and sends a `POST` request with an action of `/login`.

+ In the controller action that processes the `POST` request, you'll want to find the user in the database based on their username.

+ If there is a match, set the session to the user's ID, redirect them to the `/account` route (using `redirect to`), and use ERB to display the user's data on the page.

+ If there is no match, render the error page.

+ On the `/account` page, set up a link called 'Log Out' that clears the session.

+ In `app/helpers/helpers.rb`, you'll notice a predefined `Helpers` class. In this class, you'll want to define two **class** methods, `current_user` and `is_logged_in?`.

+ `current_user` should accept the session hash as an argument. This method should use the `user_id` from the session hash to find the user in the database and return that user.

+ `is_logged_in?` should also accept the session hash as an argument. This method should return true if the `user_id` is in the session hash and false if not. The Ruby `!!` operator will come in handy here.

+ In `account.erb`, you'll want to use the `is_logged_in?` helper method to only display the username and account balance if the user is logged in. Otherwise, it should contain a link to the home page. You'll also want to use `current_user` to display the username and balance.

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/sinatra-logging-in-and-out' title='Sinatra Sessions Lab - User Logins'>Sinatra Sessions Lab - User Logins</a> on Learn.co and start learning to code for free.</p>
