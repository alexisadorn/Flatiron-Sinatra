# Using Sessions

## Objectives

1. Gain a deeper understanding of sessions in a web application.
2. Use sessions to persist information across multiple HTTP requests in a Sinatra app. 

## Sessions and Data Persistance 

The Hyper-Text Transfer Protocol (HTTP) is, by definition, a stateless protocol. What does "stateless" mean? HTTP is called a "stateless protocol" because a browser does not attach special meaning to a request, and consequently does not require the server to retain any information about a user or entity for the duration of a request.

For example, when you log in to http://www.learn.co, you fill out a form with your Github username and password. Learn receives that information and, at that moment in time, knows who you are by matching up that log in information, submitted via a HTTP POST request, with data in its database. What about after you log in? After you log in and click a link for a particular lesson, you are sending another HTTP request to Learn. At this point in the process of your interaction with the Learn web application, Learn has no idea who you are! But wait, you might be thinking: *"Didn't I just log in? How can Learn forget so easily?"* That is what it means to be "stateless". Each web request you send is, from the point of view of the application that is receiving that request, totally independent. 

Then how, you might be wondering, does Learn (and every other web app) know who I am after I log in? Through the use of **sessions**. 

A session is a hash that lives in your application in the server. The session hash can be accessed in any controller file of your application. Whatever data is stored in the session hash can thus be accessed, added to, changed or deleted in any controller file or route at any time *and that change persists* for the duration of the session. 

When we say "duration of the session", we mean the period of time in which you, the client, are interacting with the web application. This is usually the time in between logging in and logging out. 

In fact, the act of "logging in", is simply the the act of having your user id stored inside the session hash. The act of "logging out" is simply the act of your user id being removed from the session hash. 

The session hash is most commonly used to store info like a user's id, which the web application will use to know who is the "current user" and show that user the appropriate information (for example, their profile page, their shopping cart, etc). However, we can put anything we want inside the session hash. 

## Overview

In this lab, we'll be manipulating the session hash *across HTTP requests*. That means that we will store, change, retrieve and delete session data in different controller routes. We'll see that changes we make to the session hash in one controller route will persist after subsequent web requests to other controller routes. 

### Using Sessions in Sinatra

Open up the controller file of this project, `app.rb`. Check out the following lines of code: 

```ruby
configure do
    enable :sessions unless test?
    set :session_secret, "secret"
  end
```

These lines are enabling our application to use the `sessions` keyword to access the session hash. We are also setting a session secret. Don't worry too much about the session secret for now, just know that it keeps our session data safe from outsiders. 

### Instructions

*Remember to `bundle install` before proceeding!*

### Part I: storing data in and retrieving data from the session hash

* Run `shotgun` to start up your app. 
* Navigate to the `/first_exercise` path. Follow the instructions in the browser for each step, and be sure to run `learn` before implementing each step. Make each test pass before proceeding to the next step.

### Part II: logging in and logging out

* Navigate to the `/second_exercise` path. As in the previous lesson, be sure to run `learn` before implementing each step.

* In this exercise, we'll be setting the `:id` key of the `session` hash equal to a value of `1`. Why are we doing this? The session is simply a way to store user data on a temporary basis. In any web application, a user ID is typically used as a session ID. This is because an ID attribute of a user is a unique identifier that will always be distinguishable from other user ID attributes. 

Consequently, the act of "logging in" a user works like this: 

1. User fills out a log in form with their email and password. User hits "submit" and posts that form to a route in the controller. 
2. That controller route gets the email and password from the params. Then, we search the database for a user with that info. Something like `User.find_by(email: params[:email], password: params[:password])`.
3. The `session[:id]` is set to the ID of that user. 

* Now, navigate to the '/fetch_session_id' route. Notice that we can access and render in the browser the `session[:id]` value. Remember that the session hash, and its content, is available in *any controller route*. That means that whatever you store in there can be accessed at any time. Storing information about the user currently interacting with, or logged into, your app will allow you to know who the current user is on any page of your app. 

* Once you have the `GET '/fetch_session_id'` test passing, checkout the `get '/logout'` route in your controller, `app.rb`. Here we will accomplish the act of "logging out" our imaginary user. The act of "logging out" is simply the act of clearing the content of the session hash, including the `:id` key. The `.clear` method that you can call on any hash should accomplish this. 

And that's it! 

### Resources
- [Primer on Cookie-Based Sessions](http://www.allaboutcookies.org/cookies/session-cookies-used-for.html)

<a href='https://learn.co/lessons/sinatra-sessions' data-visibility='hidden'>View this lesson on Learn.co</a>

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/sinatra-sessions'>Sinatra Sessions Codealong</a> on Learn.co and start learning to code for free.</p>

<p class='util--hide'>View <a href='https://learn.co/lessons/sinatra-sessions'>Sinatra Sessions Codealong</a> on Learn.co and start learning to code for free.</p>
