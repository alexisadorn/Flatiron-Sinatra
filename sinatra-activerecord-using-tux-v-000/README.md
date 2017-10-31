# Using Tux in Sinatra with ActiveRecord

## Overview

In this lesson, we'll cover Tux, a Ruby gem, that you can use to make sure your database and ActiveRecord associations are set up properly. 

## Objectives

* Describe the benefits of Tux
* Set up Tux locally
* Create, edit, delete, and update data

## What Is Tux

Tux is an incredible Ruby gem that lets you access your database and perform all CRUD operations on it through the terminal. It also loads a full environment in the console that allows you to see all routes and views. Primarily, you'll use Tux to make sure your database is set up properly, play around with Ruby objects, and make sure your ActiveRecord associations are working properly.

For example, in this repo there is a simple Sinatra app with a `User` model and a method called `say_name`. I want to test that the `say_name` method works. Wouldn't it be great if we could enter into some sort of playground environment where we can test out our code?

In the past, we've used IRB for just that. Let's try dropping into IRB and testing out our code. 

Open up IRB in terminal and require the file `models/user.rb`:

![require models/user.rb](http://readme-pics.s3.amazonaws.com/sinatra-tux-irb-error.png)

Oh no! We get an error that it doesn't recognize `ActiveRecord`. Let's try to require the ActiveRecord gem:
![require activerecord](http://readme-pics.s3.amazonaws.com/sinatra-tux-irb-error2.png)

Trying to test our `User` model and methods in IRB is a big big mess. We keep running into issues. This is why Tux exists. By using the Tux gem, we can easily create objects, and test our methods to manipulate those objects.

## Setup

Setting up Tux is fairly simple. All you need to do is include it in your Gemfile and run `bundle install` in terminal.

## Using Tux

We've got a full Sinatra application with a single `User` class set up. We've already created the migration for you, but make sure you actually run the migration to create the user table.

Next, it's time to use Tux. In terminal in the directory of this walk-through enter `tux`. You should see something like this:

<img src="https://curriculum-content.s3.amazonaws.com/web-development/Sinatra/Tux.png">

The tux console has now loaded. Regular terminal commands won't work at this point, but you can use Ruby and ActiveRecord methods.

### Create

Just like in our controller action, we can create a user.

```ruby
user = User.create(:name => "Trisha", :email => "trisha@test.com", :fav_icecream => "mint chocolate chip")
```

Or:

```ruby
user = User.new
user.name = "Beth"
user.email = "beth@beth.com"
user.fav_icecream = "rocky road"
user.save
```

### Edit

We can edit a user that's already been saved to the database. Let's edit the first user.

```ruby
user = User.first
user.name = "Trisha Yearwood"
user.save
```

### Delete

Now let's delete the first user:

```ruby
user = User.first
user.delete
```

### Search for Specific Users

All the `find` methods work in Tux too!

```ruby
user = User.find_by_id(2)
user = User.find_by(:name => "Beth")
user = User.first
user = User.last
```

Once you're done, just exit Tux by entering `exit`.

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/sinatra-activerecord-using-tux' title='Using Tux in Sinatra with ActiveRecord'>Using Tux in Sinatra with ActiveRecord</a> on Learn.co and start learning to code for free.</p>
