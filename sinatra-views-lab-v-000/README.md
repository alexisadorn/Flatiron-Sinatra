# Sinatra Views Lab

## Objectives

1. Respond to HTTP Requests with Sinatra Routes.
2. Render ERB from a Sinatra Action.

## Overview

This lesson practices creating ERB views and rendering them from a Sinatra Action in response to an HTTP request. Fork and clone this repository and run `bundle install` to get started!

## Instructions

For each of the following examples, create a .erb file in the `views` directory and a route in `app.rb` which renders that template. Make sure each template contains the requested content.

Run `shotgun` to start a local server so that you can test your app in your browser. Once your application is running, assuming port 9393, the shotgun default, you should be able to hit the following local urls: http://localhost:9393/hello , http://localhost:9393/goodbye , and http://localhost:9393/date.

You can run `learn` to get the tests passing and see errors.

1. Create a template called `hello.erb` in `views` that contains an `h1` tag with the content `Hello World`. This should get rendered via a GET `/hello` route by your `App` controller in `app.rb`.

2. Create another template called `goodbye.erb` in `views`. In this view, use ERB tags to create a variable `name`. This variable should store the name `Joe`. Then, using ERB tags, say "Goodbye Joe" in an `h1` tag. This should get rendered via a GET `/goodbye` route by your `App` controller in `app.rb`.

3. Create a template called `date.erb` in `views` that gets rendered via GET `/date`. It should contain an `h1` with the content `Today` 
Using ERB tags, and the DateTime library, display today's date in a `p` tag. The date should be formatted to look something like this `The date is Wednesday, November 18, 2015`.

<a href='https://learn.co/lessons/sinatra-views-lab' data-visibility='hidden'>View this lesson on Learn.co</a>

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/sinatra-views-lab'>Sinatra Views Lab II</a> on Learn.co and start learning to code for free.</p>
