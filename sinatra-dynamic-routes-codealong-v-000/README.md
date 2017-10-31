# Dynamic Routes in Sinatra

## Overview

In this code-along lesson, we'll learn why dynamic routes are powerful and how to integrate them into a Sinatra project.

## Objectives

1. Explain the purpose of dynamic routes
2. Create dynamic routes in the controller
3. Use URL params to help get the text from the URL into the views
4. Show the relationship between dynamic routes and the browser URL

## Why Dynamic Routes Matter

How does AirBnB create a separate url for every property it hosts on its site? Would it make sense to hard-code hundreds of thousands of routes (`get '/property1'`, `get '/property2'`,`get '/property2356'`) in the controller to display each rental property? The controller would get messy and long very quickly. Instead, AirBnB (and Twitter, and Facebook, etc) use *dynamic routes* - routes that are created based on attributes within the url of the request. In this code-along we'll learn why dynamic routes are powerful and how to integrate them into a Sinatra project.

To code along, fork and clone this lab. Run `bundle install` to make sure all of your dependencies are installed. Run `shotgun` to make sure that your application can run. There are tests, so make sure you're running `learn` periodically to make sure your code is behaving as expected.

### Starter Code

Open up `app.rb` in your text editor. You'll notice two routes, `get '/hello'` and `get '/hello/:name'`.

The first route is familiar looking to us. It returns the string "hello world" in the browser when we go to the url. This is an example of static routing, which we've seen.

But `get '/hello/:name'` is very different. What's with that `:` in front of `name`? This is an example of a `dynamic route`.

Eventually we are going to need to capture data from the user. We need to know who they want to say hello to. There are a few ways to get this information, and the easiest is built right into the URL. They are already typing that URL into the box at the top of their browser, so let's use it to get a bit more information.


## Dynamic Routes

In your browser, head to `http://localhost:9393/hello/danny`. Now go to `http://localhost:9393/hello/victoria` and `http://localhost:9393/hello/lyel`. Notice how the content on the page changes depending on what we type as the URL in the browser. This is the beauty of dynamic routing - it allows us to take input straight from the url, instead of through a form. In doing so, we can modify the content of a view at the moment the `get` request is received by the controller.

### How Dynamic Routes Work:

It's important to note that in Sinatra a route is simply an HTTP method/verb that is paired with a URL-matching pattern. When your Sinatra application receives a request, it will match that route to a specific controller action that matches that URL pattern.

The best way to explain routes is by going through an example. Our application is a medicine application that has an array containing three instances of a Medicine class.

Here's our array:

```ruby
all_the_medicines = [
  #<Medicine:0x007fb739b1af88 @id=1, @name="penicillin" @group="antibiotic">,
  #<Medicine:0x007fb739b1af88 @id=2, @name="advil" @group="anti-inflammatory">,
  #<Medicine:0x007fb739b1af88 @id=3, @name="benadryl" @group="anti-histamine">
]
```

Our application gets a request :`GET /medicines/1`. What happens here?

The first thing Sinatra does is try to match the request to a specific controller action. The controller action it would match is as follows: `get '/medicines/:id'`. Once the request has been matched to the controller action, it then executes the code inside of the controller action block, as shown below:

```ruby
# medicines_controller.rb
get '/medicines/:id' do
  @medicine = all_the_medicines.select do |medicine|
    medicine.id == params[:id]
  end.first
  erb :'/medicines/show.html'
end
```

Let's run through this specific scenario. The HTTP request verb, `GET` matches the `get` method in our controller. The `/medicines` path in the HTTP request matches the `/medicines` path in our controller method. Finally, the `1`, which is an `id` parameter that's being passed into the path, matches the controller's expectation for an `id` parameter to be passed in place of `:id`.

### URL Params

A URl parameter is a variable whose values are set dynamically in a page's URL, and can be accessed by its corresponding controller action. It's a very similar concept to a dynamic url.

The next thing that happens is that the `all_the_medicines` array is queried for a medicine object that has the `id` of 1. It seems to match this entry: `#<Medicine:0x007fb739b1af88 @id=1, @name="penicillin" @group="antibiotic">,`. The attributes from this object are assigned to the variable `@medicine`.

Finally, the `@medicine` object is rendered via the `show.html.erb` template inside of the `views/medicines` directory.

Going back to our initial example, if you played around enough with the examples above, you'll notice that whatever name you typed in the url also appeared in the browser, saying hello to that person. How were we able to get the text from the URL to the views?

URL params help us get the text from the URL into the views. That `:name` in the route name is just a symbol that will be filled in with text later. The data is passed from the URL to the controller action through an automatically generated hash called `params`. Don't worry too much how the hash is created. Just know that inside your controller action, you automatically have access to this hash through the variable `params`.

To continue the medicine example, the hash looks something like this:

```ruby
params = {
  :id => 1
}
```
The key of the hash is determined by the symbol in the url (`:id`), and the associated value will be the content in the url provided by the user (`1`). Once inside the controller action, we can access the value from the params hash, just like we would any other hash

```ruby
params[:id]
```

You can receive multiple pieces of data through a dynamic route by separating the content with a forward slash. For example, `get '/addnumbers/:number1/:number2'` would give you a params hash with two key-value pairs (`number1` and `number2`).

## Create your Own Dynamic Routes

Using the example dynamic route that we included in the code-along as a template, create the following two routes:

+ `get '/goodbye/:name`, a dynamic route that returns `"Goodbye, (person's name)."`, a string. For example, navigating to `localhost:9393/goodbye/jerome` should display `Goodbye, jerome.`

+ A dynamic route starting with `/multiply` that accepts two params (num1 and num2) and returns the product of the two numbers.

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/sinatra-dynamic-routes-codealong' title='Dynamic Routes in Sinatra'>Dynamic Routes in Sinatra</a> on Learn.co and start learning to code for free.</p>