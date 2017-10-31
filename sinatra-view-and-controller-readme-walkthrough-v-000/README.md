# Passing Data Between Views and Controllers in Sinatra

## Overview

In this code-along, we'll show you how to pass data back to views from your controller using an instance variable, and then render it using ERB.

## Objectives

1. Pass data from a form to a controller using `params`
2. Manipulate data inside of a route in the controller
3. Assign data to an instance variable
4. Render data in a `.erb` file using erb tags

## Setup

Why is passing data back to views from your controller so important? It allows us to make your pages *dynamic* rather than *static* - that is, the data can change depending on the inputs provided by the user. As an example, we'll be creating a "String Reverser" - the user inputs a string ("Hello World") into an HTML form, and is shown the reverse of the string ("dlroW olleH") on the following page.

To code along, fork and clone this repository. Run `bundle install` from the command line to ensure you have the proper dependencies installed. The starter code contains a basic Sinatra application which you can access by running `shotgun` in your command line and then opening `http://localhost:9393/reverse` in your browser.

### Starter Code

Let's take a closer look at the starter code.

#### Views
+ `reverse.erb` has a form that has one text input tag: `<input type="text" name="string"> `. Remember that the name attribute becomes the key for the form data in the `params` hash. The form has a method attribute of `POST`, and an action attribute of `/reverse`.
+ `reversed.erb` which will eventually show the reversed version of the string submitted by the user.
+ `friends.erb`, which we'll be using to talk about iteration in erb.
+ **Note:** The views all have basic CSS styling (linked using the `<link`> tag) that can be found in `style.css` in the `public/stylesheets` folder.

#### Routes
+ The controller has three routes:
	+  `get '/reverse' do`, which renders the `reverse.erb` page.
	+  `post '/reverse' do`, which receives that 	params hash from the form (but does nothing with it) and renders the `reversed.erb` page.
	+  `get '/friends' do`, which renders the `friends.erb` page.


## Manipulating Params in the Controller

Let's start by taking a look at our params when we submit the form on the /reverse page. The easiest way to do this is to find the post route to which the form is sending data - in this case `post /reverse do` - and add a `puts params` inside the method:

```ruby
post '/reverse' do
  puts params

  erb :reversed
end
```
 When we submit the form, the contents of params will output **in the console**. Let's submit "hello friend" to the form and look at `params` in our console:

![Puts Params](https://s3.amazonaws.com/learn-verified/puts-params.png)


To manipulate the string, let's take it out of the params hash, and then call the `.reverse` method on it:
```ruby
post '/reverse' do
  original_string = params["string"]
  reversed_string = original_string.reverse

  erb :reversed
end
```
We now have a reversed version of the original string submitted by the user. Great! But it's in our controller, which our user will never see. How do we pass this data back in to a view?

## Using Instance Variables

Instance variables allow us to bypass scope between the various methods in a class. Creating an instance variable in a controller method (route) lets the contents become 'visible' to the erb file to which it renders. Instead of creating a local variable `reversed_string`, change it to an instance variable `@reversed_string`.

```ruby
post '/reverse' do
  original_string = params["string"]
  @reversed_string = original_string.reverse

  erb :reversed
end
```
We can now access the contents of `@reversed_string` inside of our view, `reversed.erb`.

**Note:** Instance variables are ONLY passed from the controller method where they are created to the view that is rendered, not between controller methods. For example:

```ruby
get "/" do
  @user = "Ian"

  erb :index # @user will be defined as 'Ian' in the view
end

get "/profile" do
  erb :profile # @user will be nil here
end
```

## Rendering using ERB tags

Right now the content of `reversed.erb` is just plain old vanilla HTML in a .erb file. In order to show the content of a Ruby string, we need to use erb tags. As a recap:

+ `<%= contents %>` will display the evaluated expression within the opening and closing.
+ `<% contents %>` will evaluate the contents of the expression, but will not display them.

We know that the contents of `@reversed_string` are available to the erb file, so let's put them together:

```erb
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>The Ultimate Reversed String!</title>
    <link rel="stylesheet" href="stylesheets/style.css" type="text/css">
  </head>

  <body>
    <h1>The Ultimate Reversed String!</h1>

    <!--   Use ERB tags to bring in an instance variable containing the reversed string -->
    <h2><%= @reversed_string %></h2>
  </body>
</html>
```
Notice that we've put the erb tag with `@reversed_string` within `<h2>` tags. Just some additional styling!

## Iterating in ERB

We have one additional `get` request that we're going to use to practice sending data from the controller to a view. In this case, we want to assign an array (rather than a string) to an instance variable. Let's create an array called `@friends` inside of the `get '/friends' do` route, and render the `friends.erb` page:

```ruby
get '/friends' do
  @friends = ['Emily Wilding Davison', 'Harriet Tubman', 'Joan of Arc', 'Malala Yousafzai', 'Sojourner Truth']

  erb :friends
end
```
In friends.erb, we want to show each item in the array inside of its own `<h2>` tag. Unfortunately this won't work:

```erb
<%# BAD EXAMPLE %>

<h2><%= @friends %></h2>
```

Instead, we'll have to use iteration with the `.each` method to loop through each item in the array and put it in its separate `<h2>` tag. Let's start with the iterator - notice that we're using erb tags that don't display the evaluated expression:

```erb
<% @friends.each do |friend| %>

<% end %>
```

Next, let's set up what we want to do for each item:

```erb
<% @friends.each do |friend| %>
	<h2><%= friend %></h2>
<% end %>
```

This will set up a loop through all items in `@friends` and then place each item in the array in its own `<h2>` tag. The rendered HTML will look like this:

```html
<h2>Emily Wilding Davison</h2>
<h2>Harriet Tubman</h2>
<h2>Joan of Arc</h2>
<h2>Malala Yousafzai</h2>
<h2>Sojourner Truth</h2>
```
You can imagine how powerful iteration in erb is when you have an array of thousands of items that you have to display in your view!

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/sinatra-view-and-controller-readme-walkthrough' title='Passing Data Between Views And Controllers in Sinatra'>Passing Data Between Views And Controllers in Sinatra</a> on Learn.co and start learning to code for free.</p>
