# Sinatra and Active Record: Associations and Complex Forms

## Objectives

1. Build forms that allow a user to create and edit a given resource and its associated resources.
2. Build controller actions that handle the requests sent by such forms.

## Introduction

As the relationships we build between our models grow and become more complex, we need to build ways for our users to interact with those models in all of their complexity. If a genre has many songs, then a user should be able to create a new song *and* select from a list of existing genres and/or create a new genre to be associated with that song, all at the same time. In other words, if our models are associated in a certain way, our users should be able to create and edit instances of those models in ways that reflect those associations.

In order to achieve this, we'll have to build forms that allow for a user to create and edit not just the given object but any and all objects that are associated with it.

## Overview

**This is a walk-through with some extra challenges for you to complete on your own. There are tests, so be sure to run the tests to make sure you're following along correctly. To follow along, use `shotgun` to start your app and visit URLs/fill out forms as instructed.** In this walk-through, we're dealing with a pet domain model. We have an `Owner` model and a `Pet` model. An owner has many pets, and a pet belongs to an owner. We've already built the migrations, models, and some controller actions and views. Fork and clone this lab to follow along.

Because an owner can have many pets, we want to be able to choose which of the existing pets in our database to associate to a new owner *when the owner is being created*. We also want to be able to create a new pet *and associate it with the owner being created*. So, our form for a new owner must contain a way to select a number of existing pets to associate with that owner as well as a way to create a brand new pet to associate with that owner. The same is true of editing a given owner: we should be able to select and deselect existing pets and/or create a new pet to associate with the owner.

Here, we'll be taking a look together at the code that will implement this functionality. Then, you'll build out the same feature for creating/editing new pets.

## Instructions

### Before You Begin

Since we've provided you with much of the code for this project, take a few moments to go through the provided files and familiarize yourself with the app. Note that an owner has a name and has many pets and a pet has a name and belongs to an owner. Note that we have two separate controllers, one for pets and one for owners, each of which inherit from the main application controller. Note that each controller has a set of routes that enable the basic CRUD actions (except for delete –– we don't really care about deleting for the purposes of this exercise).

**Make sure you run `rake db:migrate` and `rake db:seed` before you move on**. This will migrate our database and seed it with one owner and two pets to get us started.

#### A Note on Seed Files

The phrase 'seeding the database' refers to the practice of filling up your database with some dummy data. As we develop our apps, it is essential that we have some data to work with. Otherwise, we won't be able to tell if our app is working or try out the actions and features that we are building. Sinatra makes it easy for us to seed our database by providing us with something called a seed file. This file should be placed in the `db` directory, `db/seeds.rb`. The seed file is where you can write code that creates and saves instances of your models.

When you run the seed task provided by Sinatra and Rake, `rake db:seed`, the code in the seed file will be executed, inserting some sample data into your database.

Go ahead and open up the seed file in this app, `db/seeds.rb`. You should see the following:

```ruby
 # Add seed data here. Seed your database with `rake db:seed`
sophie = Owner.create(name: "Sophie")
Pet.create(name: "Maddy", owner: sophie)
Pet.create(name: "Nona", owner: sophie)
```

This is code you should be pretty familiar with by now. We are simply creating and saving an instance of our `Owner` class and creating and saving two new instances of the `Pet` class.

So, when `rake db:seed` is run, the code in this file is actually executed, inserting the data regarding Sophie, Maddy, and Nona into our database.

You can write code to seed your database in any number of ways. We've done it fairly simply here, but you could imagine writing code in your seed file that sends a request to an external API and instantiates and saves instances of a class using the response from the API. You could also write code that opens a directory of files and uses information about each file to create and save instances of a class. The list goes on.

### Creating a New Owner and Their Associated Pets

Open up `app/views/owners/new.erb` and you should see the following code:

```html
<h1>Create a new Owner</h1>

<form action="/owners" method="POST">
  <label>Name:</label>

  <br></br>

  <input type="text" name="owner[name]" id="owner_name">

  <input type="submit" value="Create Owner">
</form>
```

Here we have a basic form for a new owner with a field for that new owner's name. However, we want our users to be able to create an owner and select existing pets to associate with that new owner *at the same time*. So, our form should include a list of checkboxes, one for each existing pet, for our user to select from at will.

How can we dynamically, or programmatically, generate a list of checkboxes for all of the pets that are currently in our database?

#### Dynamically Generating Checkboxes

In order to dynamically generate these checkboxes, we need to load up all of the pets from the database. Then, we can iterate over them in our `owners/new.erb` view using ERB tags to inject each pet's information into a checkbox form element. Let's take a look:

```ruby
# controllers/owners_controller.rb
get '/owners/new' do
  @pets = Pet.all
  erb :'owners/new'
end
```

```html
# views/owners/new.erb
<%@pets.each do |pet|%>
    <input type="checkbox" name="owner[pet_ids][]" value="<%=pet.id%>" id="<%=pet.id%>"><%=pet.name%></input>
<%end%>
```
Let's break this down:

* We use ERB to get all of the pets with `Pet.all`, then we iterate over that collection of `Pet` objects and generate a checkbox for each pet.
* That checkbox has a `name` of `"owner[pet_ids][]"` because we want to structure our `params` hash such that the array of pet IDs is stored inside the `"owner"` hash. We are aiming to associate the pets that have these IDs with the new owner.
* We give the checkbox a `value` of the given pet's ID. This way, when that checkbox is selected, its value, i.e., the pet's ID, is what gets sent through to the `params` hash.
* We give the checkbox an `id` of the given pet's ID so that our Capybara test can find the checkbox using the pet's ID.
* Finally, in between the opening and closing input tags, we use ERB to render the given pet's name.

The result is a form that looks something like this:

![](http://readme-pics.s3.amazonaws.com/create-owner-orig.png)


Let's place a `binding.pry` in the `post '/owners'` route and submit our form so that we can get a better understanding of the `params` hash we're creating with our form. Once you hit your binding, type `params` in the terminal, and you should see something like this:

```ruby
{"owner"=>{"name"=>"Adele", "pet_ids"=>["1", "2"]}}
```

I filled out my form with a name of "Adele", and I checked the boxes for "Maddy" and "Nona". So, our `params` hash has a key of `"owner"` that points to a value that is a hash containing two keys: `"name"`, with a value of the name entered into the form, and `"pet_ids"`, with a value of an array containing the ids of all of the pets we selected via our checkboxes. Let's move on to writing the code that will create a new owner *and* associate it to these pets.

#### Creating New Owners with Associated Pets in the Controller

We are familiar with using mass assignment to create new instances of a class with Active Record. For example, if we had a hash, `owner_info`, that looked like this...

```ruby
owner_info = {name: "Adele"}
```

...we could easily create a new owner like this:

```ruby
Owner.create(owner_info)
```

But our `params` hash contains this additional key of `"pet_ids"` pointing to an array of pet ID numbers. You may be wondering if we can still use mass assignment here. Well, the answer is yes. Active Record is smart enough to take that key of `pet_ids`, pointing to an array of numbers, find the pets that have those IDs, and associate them to the given owner, all because we set up our associations such that an owner has many pets. Wow! Let's give it a shot. Still in your Pry console that you entered via the `binding.pry` in the `post '/owners'` action of the `OwnersController`, type:

```ruby
@owner = Owner.create(params["owner"])
# => #<Owner:0x007fdfcc96e430 id: 2, name: "Adele">
```

It worked! Now, type:

```ruby
@owner.pets
#=> [#<Pet:0x007fb371bc22b8 id: 1, name: "Maddy", owner_id: 2>, #<Pet:0x007fb371bc1f98 id: 2, name: "Nona", owner_id: 2>]
```

And our usage of mass assignment successfully associated the new owner with the pets whose ID numbers were in the `params` hash!

Now that we have this working code, let's go ahead and place it in our `post '/owners'` action:

```ruby
# app/controllers/owners_controller.rb

post '/owners' do
  @owner = Owner.create(params[:owner])
  redirect "owners/#{@owner.id}"
end
```

Great! We're almost done with this feature. But, remember that we want a user to be able to create a new owner, select some existing pets to associate with that owner, *and* also have the option of creating a new pet to associate with that owner. Let's build that latter capability into our form.

#### Creating a New Owner and Associating Them with a New Pet

This will be fairly simple. All we need to do is add a section to our form for creating a new pet:

```html
and/or, create a new pet:
    <br></br>
    <label>name:</label>
      <input  type="text" name="pet[name]"></input>
    <br></br>
```

Now our whole form should look something like this:

```html
<h1>Create a new Owner</h1>

<form action="/owners" method="POST">
  <label>Name:</label>

  <br></br>

  <input type="text" name="owner[name]" id="owner_name">

  <br></br>

  <label>Choose an existing pet:</label>

  <br></br>

  <%Pet.all.each do |pet|%>
    <input type="checkbox" name="owner[pet_ids][]" id="<%=pet.id%>" value="<%=pet.id%>"><%=pet.name%></input>
  <%end%>

  <br></br>

    <label>and/or, create a new pet:</label>
    <br></br>
    <label>name:</label>
      <input  type="text" name="pet[name]"></input>
    <br></br>
  <input type="submit" value="Create Owner">
</form>
```

Note that we've included the section for creating a new pet at the bottom of the form and we've given that input field a `name` of `pet[name]`. Now, if we fill out our form like this...

![](http://readme-pics.s3.amazonaws.com/creat-owner-two.png)

...when we submit our form, our `params` hash should look something like this:

```ruby
{"owner"=>{"name"=>"Adele", "pet_ids"=>["1", "2"]}, "pet"=>{"name"=>"Fake Pet"}}
```

Our `params["owner"]` hash is unchanged, so `@owner = Owner.create(params["owner"])` still works. But what about creating our new pet with a name of `"Fake Pet"` and associating it to our new owner?

For this, we'll have to grab the new pet's name from `params["pet"]["name"]`, use it to create a new pet, and add the new pet to our new owner's collection of pets:

```ruby
@owner.pets << Pet.create(name: params["pet"]["name"])
```

But, you might be wondering, what if the user *does not* fill out the field to name and create a new pet? In that case, our `params` hash would look like this:

```ruby
{"owner"=>{"name"=>"Adele", "pet_ids"=>["1", "2"]}, "pet"=>{"name"=>""}}
```

The above line of code would create a new pet with a name of an empty string and associate it to our owner. That's no good. We'll need a way to control whether or not the above line of code runs. Let's create an `if` statement to check whether or not the value of `params["pet"]["name"]` is an empty string.

```ruby
if !params["pet"]["name"].empty?
  @owner.pets << Pet.create(name: params["pet"]["name"])
end
```

That looks pretty good. Let's put it all together:

```ruby
post '/owners' do
  @owner = Owner.create(params[:owner])
  if !params["pet"]["name"].empty?
    @owner.pets << Pet.create(name: params["pet"]["name"])
  end
  @owner.save
  redirect to "owners/#{@owner.id}"
end
```

Let's sum up before we move on. We:

* Built a form that dynamically generates checkboxes for each of the existing pets.
* Added a field to that form in which a user can fill out the name for a brand new pet.
* Built a controller action that uses mass assignment to create a new owner and associate it to any existing pets that the user selected via checkboxes.
* Added to that controller action code that checks to see if a user did in fact fill out the form field to name and create a new pet. If so, our code will create that new pet and add it to the newly-created owner's collection of pets.

Now that we can create a new owner with associated pets, let's build out the feature for editing that owner and their associated pets.

### Editing Owners and Associated Pets

Our edit form will be very similar to our create form. We want a user to be able to edit everything about an owner: the owner's name, any existing pet associations, and any new pet the user would like to create and associate with that owner. So, our form should have the standard, pre-filled name field as well as dynamically generated checkboxes for existing pets. This time, though, the checkboxes should be automatically checked if the given owner already owns that pet. Finally, we'll need the same form field we built earlier for a user to create a new pet to be associated with our owner.

Let's do it!

```html
# edit.erb
<h1>Update Owner</h1>

<form action="/owners/<%=@owner.id%>" method="POST">
  <label>Name:</label>

  <br></br>

  <input type="text" name="owner[name]" id="owner_name" value="<%=@owner.name%>">

  <br></br>

  <label>Choose an existing pet:</label>

  <br></br>

  <%Pet.all.each do |pet|%>
    <input type="checkbox" name="owner[pet_ids][]" id="<%= pet.id%>" value="<%=pet.id%>" <%='checked' if @owner.pets.include?(pet) %>><%=pet.name%></input>
  <%end%>

  <br></br>

  <label>and/or, create a new pet:</label>
  <br></br>
  <label>name:</label>
    <input  type="text" name="pet[name]" id="pet_name"></input>
  <br></br>
  <input type="submit" value="Update Owner">
</form>
```

The main difference here is that we added the `checked` property to each checkbox with a condition to test whether the given pet is already present in the current owner's collection of pets. We implemented this `if` statement by wrapping the `checked` attribute in ERB tags, allowing us to use Ruby on our view page.

Go ahead and make some changes to your owner using this edit form, then place a `binding.pry` in your `post '/owners/:id'` action and submit the form. Once you hit your binding, type `params` in the terminal.

I filled out my edit form like this:

![](http://readme-pics.s3.amazonaws.com/update-owner.png)

Notice that I've unchecked the first two pets, Maddy and Nona, and checked the next two pets.

My `params` hash consequently looks like this:

```ruby
{"owner"=>{"name"=>"Adele", "pet_ids"=>["3", "4"]},
 "pet"=>{"name"=>"Another New Pet"},
 "splat"=>[],
 "captures"=>["8"],
 "id"=>"8"}
```

#### Updating Owners in the Controller

Let's update our owner with this new information. Just as Active Record was smart enough to allow us to use mass assignment to not only create a new owner but to associate that owner to the pets whose IDs were contained in the `"pet_ids"` array, it is also smart enough to allow us to update an owner in the same way. In our Pry console in the terminal, let's execute the following:

```ruby
@owner = Owner.find(params[:id])
@owner.update(params[:owner])
```

Now, if we type `@owner.pets`, we'll see that the owner is no longer associated to the pets with an ID of 1 or 2, but they are associated to pets 3 and 4:

```ruby
@owner.pets
# => [#<Pet:0x007fd511d5e560 id: 3, name: "SBC", owner_id: 8>,
 #<Pet:0x007fd511d5e3d0 id: 4, name: "Fake Pet", owner_id: 8>]
```

Great! Now, we need to implement logic similar to that in our `post '/owners'` action to handle a user trying to associate a brand new pet to our owner:

```ruby
post '/owners/:id' do
  @owner = Owner.find(params[:id])
  @owner.update(params["owner"])
  if !params["pet"]["name"].empty?
    @owner.pets << Pet.create(name: params["pet"]["name"])
  end
  redirect to "owners/#{@owner.id}"
end
```

And that's it!

### Creating and Updating Pets with Associated Owners

Now that we've walked through these features together for the `Owner` model, take some time and try to build out the same functionality for `Pet`. The form to create a new pet should allow a user to select from the list of available owners and/or create a new owner, and the form to edit a given pet should allow the user to select a new owner or create a new owner. Note that if a new owner is created it would override any existing owner that is selected. 

Make sure you run the tests to check your work.

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/sinatra-complex-forms-associations' title='Sinatra and Active Record: Associations and Complex Forms'>Sinatra and Active Record: Associations and Complex Forms</a> on Learn.co and start learning to code for free.</p>

<p class='util--hide'>View <a href='https://learn.co/lessons/sinatra-complex-forms-associations'>Sinatra Complex Forms Associations</a> on Learn.co and start learning to code for free.</p>
