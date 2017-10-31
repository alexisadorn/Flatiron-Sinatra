# Sinatra Nested Forms Lab: Superheroes!

## Overview

In this lab, you'll practice building nested forms in Sinatra for creating teams of superheroes. No database is required, but feel free to add persistence *after* you have successfully completed the instructions below.

## Instructions

### Make a form

1. Create a route that responds to a GET request at `/`.
2. Create a view with a form and render it in the GET `/` route.
3. The form should have fields for the `name` of a superhero team and their `motto`.
4. There should be form inputs for each of the three superhero member's `name`, `power`, and `bio`.

It should look something like this:

![super_hero.erb](http://i.imgur.com/Ws3nCIC.png)

### Handle form submission

1. Create a route that responds to a POST request at `/teams`.
2. Have the form send a POST request to this route.
2. Upon submission, render a template that displays the submitted team data and each member's data.

## Final Output

Your params should be nested. For example, in order to see all the superheroes for the team you just created you would enter: 

```ruby
params["team"]["members"]
```
If you wanted to access the first superhero's name, you would enter:

```ruby
params["team"]["members"][0]["name"]
```

When you post to this form you should render a page that displays the name of the team and each member of the team, along with their name, super power and bio.

Your view should display something like this:

![team.erb](http://i.imgur.com/SsVQ5e0.png)

## Deliverables

Pass the tests! You'll notice in `super_sinatra_spec.rb` in the`it submits the form` test for `'POST /teams'`, we use the Capybara method `fill_in`:

```ruby
fill_in("member1_name", :with => "Amanda")
fill_in("member1_power", :with => "Ruby")
fill_in("member1_bio", :with => "I love Ruby!")
```

The same pattern follows for the second and third superheroes. The word in quotes after `fill_in` needs to be set as an ID in the form to create the superheroes:

```html
<input id="member1_name" type="text" name="team[members][][name]">
```

***NOTE***: If you run into any trouble with Sinatra's default configuration, such as needing to set the `views` directory for a particular controller (or to something other than the default `views` folder at the top level of your application directory), take a spin through the [Sinatra configuration documentation](http://www.sinatrarb.com/configuration.html), the [Getting Started guide](http://www.sinatrarb.com/intro), or the old standbys, Google and StackOverflow.

## Resources

* [Ashley William's GitHub](https://github.com/ashleygwilliams/) - [Sinatra Form Party](https://github.com/ashleygwilliams/sinatra-form-party)

* [Ashley William's GitHub](https://github.com/ashleygwilliams/) - [Citibike Sinatra](https://github.com/ashleygwilliams/citibike-sinatra)

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/sinatra-nested-forms-lab-superheros'>Sinatra Nested Forms Lab: Superheroes!</a> on Learn.co and start learning to code for free.</p>
