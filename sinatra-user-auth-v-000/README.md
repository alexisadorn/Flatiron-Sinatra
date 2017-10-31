# User Authentication in Sinatra

## Overview

In this codealong lab, we'll build a Sinatra application that will allow users to sign up for, log into, and then log out of your application.

## Objectives

1. Explain how logging in to an application stores a user's ID into a `session` hash
2. Set up a root path and homepage for the application
3. Build a user sign-up flow with a Users model that signs in and logs in a user
4. Log out the user by clearing the `session` hash

## User Authorization: Using Sessions

### Logging In

What does it mean for a user to 'log in'? The action of logging in is the simple action of storing a user's ID in the `session` hash. Here's a basic user login flow:

1. User visits the login page and fills out a form with their email and password. They hit 'submit' to `POST` that data to a controller route.
2. That controller route accesses the user's email and password from the `params` hash. That info is used to find the appropriate user from the database with a line such as `User.find_by(email: params[:email], password: params[:password])`. **Then, that user's ID is stored as the value of `session[:id]`.**
3. As a result, we can introspect on the `session` hash in *any other controller route* and grab the current user by matching up a user ID with the value in `session[:id]`. That means that, for the duration of the session (i.e., the time between when someone logs in to and logs out of your app), the app will know who the current user is on every page.

#### A Note On Password Encryption

For the time being, we will simply store a user's password in the database in its raw form. However, that is not safe! In an upcoming lesson, we'll learn about password encryption: the act of scrambling a user's password into a super-secret code and storing a de-crypter that will be able to match up a plaintext password entered by a user with the encrypted version stored in a database.

### Logging Out

What does it mean to log out? Conceptually, it means we are terminating the session, the period of interaction between a given user and our app. The action of 'logging out' is really just the action of clearing all of the data, including the user's ID, from the `session` hash. Luckily for us, there is already a Ruby method for emptying a hash: `#clear`.

### User Registration

Before a user can sign in, they need to sign up! What does it mean to 'sign up'? A new user submits their information (for example, their name, email, and password) via a form. When that form gets submitted, a `POST` request is sent to a route defined in the controller. That route will have code that does the following:

1. Gets the new user's name, email, and password from the `params` hash.
2. Uses that info to create and save a new instance of `User`. For example: `User.create(name: params[:name], email: params[:email], password: params[:password])`.
3. Signs the user in once they have completed the sign-up process. It would be annoying if you had to create a new account on a site and *then* sign in immediately afterwards. So, in the same controller route in which we create a new user, we set the `session[:id]` equal to the new user's ID, effectively logging them in.
4. Finally, we redirect the user somewhere else, such as their personal homepage.

## Project Structure

### Our Project

Our file structure looks like this:

```bash
-app
  |- controllers
      |- application_controller.rb
  |- models
      |- user.rb
  |- views
      |- home.erb
      |- registrations
          |- signup.erb
      |- sessions
          |- login.erb
      |- users
          |- home.erb
-config
-db
-spec
...
```


### The `app` Folder 

The `app` folder contains the models, views and controllers that make up the core of our Sinatra application. Get used to seeing this setup. It is conventional to group these files under an `app` folder.

#### Application Controller

* The `get '/registrations/signup'` route has one responsibility: render the sign-up form view. This view can be found in `app/views/registrations/signup.erb`. Notice we have separate view sub-folders to correspond to the different controller action groupings.

* The `post '/registrations'` route is responsible for handling the `POST` request that is sent when a user hits 'submit' on the sign-up form. It will contain code that gets the new user's info from the `params` hash, creates a new user, signs them in, and then redirects them somewhere else.

* The `get '/sessions/login'` route is responsible for rendering the login form.

* The `post '/sessions'` route is responsible for receiving the `POST` request that gets sent when a user hits 'submit' on the login form. This route contains code that grabs the user's info from the `params` hash, looks to match that info against the existing entries in the user database, and, if a matching entry is found, signs the user in.

* The `get '/sessions/logout'` route is responsible for logging the user out by clearing the `session` hash.

* The `get '/users/home'` route is responsible for rendering the user's homepage view.

#### The `models` Folder

The `models` folder is pretty straightforward. It contains one file because we only have one model in this app: `User`.

The code in `app/models/user.rb` will be pretty basic. We'll validate some of the attributes of our user by writing code that makes sure no one can sign up without inputting their name, email, and password. More on this later.

#### The `views` Folder

This folder has a few sub-folders we want to take a look at. Since we have different controllers responsible for different functions/features, we want our `views` folder structure to match up.
* The **`views/registrations`** sub-directory contains one file, the template for the new user sign-up form. That template will be rendered by the `get '/registrations/signup'` route in our controller. This form will `POST` to the `post '/registrations'` route in our controller.
* The **`views/sessions`** sub-directory contains one file, the template for the login form. This template is rendered by the `get '/sessions/login'` route in the controller. The form on this page sends a `POST` request that is handled by the `post '/sessions'` route.
* The **`views/users`** sub-directory contains one file, the template for the user's homepage. This page is rendered by the `get '/users/home'` route in the controller.
* We also have a `home.erb` file in the top level of the `views` directory. This is the page rendered by the root route, `get '/'`.

### Part I: Models and Migrations

Our `User` model has a few attributes: a name, email, and password.

#### Step 1: Migration

Write a migration that creates a `Users` table with columns for name, email, and password. Run `rake db:migrate` and then run your test suite.

You'll see that you're passing a number of tests, including these:

```ruby
User
  is invalid without a name
  is invalid without a email
  is invalid without an password
```

Let's think about the concept of validations...

### Part II: Controllers and Views

#### Step 1: The Root Path and the Homepage

First things first, let's set up our root path and homepage.

* Open up `app/controllers/application_controller.rb` and check out the `get '/'` route. This route should render the `app/views/home.erb` page with the following code:

```ruby
erb :home
```
* Run your test suite again with `learn` or `rspec` in the command line and you should be passing these two tests:

```bash
ApplicationController
  homepage: GET /
    responds with a 200 status code
    renders the homepage view, 'home.erb'
```
* Start up your app by running `shotgun` in the terminal. Visit the homepage at [localhost:9393](http://localhost:9393/). You should see a message that welcomes you to Hogwarts and shows you a link to sign up and a link to log in.

* Let's look at the code behind this view. Open up `app/views/home.erb` and you should see the following:

```ruby
<h1>Welcome to Hogwarts</h1>
  <h4>Please sign up or log in to access your @hogwarts.edu email account</h4>
  <a href="/registrations/signup">Sign Up</a>
  <a href="/sessions/login">Log In</a>
```

Notice that we have two links, the "Sign Up" link and the "Log In" link. Let's take a closer look:

* The 'href' (destination) value of the first link is `/registrations/signup`. This means that the link points to the `get '/registrations/signup'` route.
* The 'href' value of the second link is `/sessions/login`. This means that the link points to the `get '/sessions/login'` route.

Let's move on to step 2, the building of our user sign-up flow.

#### Step 2: User Sign-up

* In your controller you should see two routes dedicated to sign-up. Let's take a look at the first route, `get '/registrations/signup'`, which is responsible for rendering the sign-up template.

```ruby
get '/registrations/signup' do
    erb :'/registrations/signup'
end
```

* Navigate to [localhost:9393/registrations/signup](http://localhost:9393/registrations/signup). You should see a page that says 'Sign Up Below:'. Let's make a sign-up form!

* Open up `app/views/registrations/signup.erb`. Our signup form needs fields for name, email, and password. It needs to `POST` data to the `'/registrations'` path, so your form action should be `'/registrations'` and your form method should be `POST`.

* Once you've written your form, go ahead and add the line `puts params` inside the `post '/registrations'` route in the controller. Then, fill out the form in your browser and hit the `"Sign Up"` button.

* Hop on over to your terminal and you should see the params outputted there. It should look something like this (but with whatever info you entered into the form):

```ruby
{"name"=>"Beini Huang", "email"=>"beini@bee.com", "password"=>"password"}
```

* Okay, so we're inside our `post '/registrations'` route, and we have our `params` hash that contains the user's name, email, and password. Inside the `post '/registrations'` route, place the following code:

```ruby
@user = User.new(name: params["name"], email: params["email"], password: params["password"])
@user.save
```

* We did it! We registered a new user! Now we just need to sign them in. On the following line, set the `session[:id]` equal to our new user's ID:

```ruby
session[:id] = @user.id
```

* Take a look at the last line of the method:

```ruby
redirect '/users/home'
```

Now that we've signed up and logged in our user, we want to take them to their homepage.

Go ahead and run the test suite again and you should see that *almost all* of the user sign-up tests are passing.

#### Step 3: Fetching the Current User

Open up the view file: `app/views/users/home.erb` and look at the following line of code:

```erb
"Welcome, <%=@user.name%>!"
```

Looks like this view is trying to operate on a `@user` variable. We know that the only variables that a view can access are instance variables set in the controller route that renders that particular view page. Let's take a look at the route in our controller that corresponds to the `/users/home` view.

Remember, after a user signs up and is signed in via the code we wrote in the previous step, we redirect to the `'/users/home'` path. Let's check out that route right now.

* Again, take a look at the controller. You should see the `get '/users/home'` route. First, this route finds the current user based on the ID value stored in the `session` hash. Then, it sets an instance variable, `@user`, equal to that found user, allowing us to access the current user in the corresponding view page. Let's set it up:

```ruby
get '/users/home' do
  @user = User.find(session[:id])
  erb :'/users/home'
end
```

* Run the tests again and we should be passing *all* of our user sign up tests.

#### Step 4: Logging In
* Go back to your homepage and look at the second of the two links:

```ruby
<a href="/sessions/login">Log In</a>
```

* This is a link to the `get '/sessions/login'` route. Checkout the two routes defined in the controller for logging in and out. We have a `get '/sessions/login'` route and a `post '/sessions'` route. 
* The `get /sessions/login'` route renders the login view page. Restart your app by executing `Ctrl + C` and then typing `shotgun` in your terminal. Navigate back to the root page, [localhost:9393](http://localhost:9393/), and click on the 'Log In' link. It should take you to a page that says 'Log In Below:'. Let's create our login form!
* Open up `app/views/sessions/login.erb`. We need a form that sends a `POST` request to `/sessions` and has input fields for email and password. Don't forget to add a submit button that says 'Log In'. Then, to test that everything is working as expected, place the line `puts params` in the `post '/sessions'` route. In your browser, fill out the form and hit 'Log In'.
* In your terminal, you should see the outputted `params` hash looking something like this (but with whatever information you entered into the login form):

```bash
{"email"=>"beini@bee.com", "password"=>"password"}
```
* Inside the `post '/sessions'` route, let's write the lines of code that will find the correct user from the database and log them in by setting the `session[:id]` equal to their user ID.

```ruby
@user = User.find_by(email: params["email"], password: params["password"])
session[:id] = @user.id
```
* Notice that the last line of the route redirects the user to their homepage. We already coded the `'/users/home'` route in the controller to retrieve the current user based on the ID stored in `session[:id]`.
* Run the test suite again and you should be passing the user login tests.

#### Step 5: Logging Out

* Open up `app/views/users/home.erb` and check out the following link:

```html
<a href="/sessions/logout">Log Out</a>
```

* We have a link that takes us to the `get '/sessions/logout'` route, which is responsible for logging us out by clearing the `session` hash.
* In the `get '/sessions/logout'` route in the controller, put:

```ruby
session.clear
```
* Run the test suite again, and you should be passing everything.

## Conclusion

Phew! This was a big code-along, and we were introduced to some new concepts. Before moving on, play around with your app a bit. Practice signing up, logging out, and logging in, and get used to the general flow.

There's a lot to think about here, but here are a few takeaways:

* Separate out your views into sub-folders according to their different concerns / controller routes.
* Signing up for an app is nothing more than submitting a form, grabbing data from the `params` hash, and using it to create a new user.
* Logging in is nothing more than locating the correct user and setting the `:id` key in the `session` hash equal to their user ID.
* Logging out is accomplished by clearing all of the data from the `session` hash.

Another important takeaway from this lab is a general understanding of the flow of information between the different routes and views of an application. If you're still confused by the flow of signing up and logging in/out, try drawing it out. Can you map out where your web requests go from the point at which you click the "Sign Up" link all the way through until you log out and then attempt to log back in? Give it a shot.

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/sinatra-user-auth' title='User Authentication in Sinatra'>User Authentication in Sinatra</a> on Learn.co and start learning to code for free.</p>
