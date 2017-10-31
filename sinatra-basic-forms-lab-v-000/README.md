# Sinatra Basic Forms Lab

<img src="https://s3.amazonaws.com/learn-verified/puppies.gif" hspace="10" align="right" width="300">

Your local pet adoption store has asked you (a frequent dog walker and visitor) to build their new site because their old one was built in WordPress and sucks. Good thing you love puppies and coding!

## Objectives

1. Implement a POST request to the controller to display data from a user in the view
2. Implement both POST and GET requests
3. Connect a controller action with both a view and a model

## Instructions

1. Build out a puppy class in `models/puppy.rb`. Puppies should have name, breed, and age attributes. You will need to be able to pass these three attributes to initialization, as well as readers and writers for the attributes.

2. In `app.rb` build out a GET request to load a home page. The home page should go to the main route `/`. 

3. The home page will also need a new view `index.erb`. This page should welcome you to the Puppy Adoption Site. Add this view to the controller action. 

4. Now, we need to create a form for a user to list a new puppy that is available for adoption. You can create this form in `views/create_puppy.erb`. Remember, you'll need to set up another controller action for a user to be able to view this form in the browser. Another reminder: the "submit" button of a form is an `<input>` element with a `type` of `"submit"`, *not* a `<button>` element. 

5. Now we need to make sure the form is being submitted properly. You'll need to have a third controller action that takes the input from the user and renders a third view (`views/display_puppy.erb`) which displays the info for the puppy that was just created.

6. Add a link on the homepage to the new puppy form.




<p data-visibility='hidden'>View <a href='https://learn.co/lessons/sinatra-basic-forms-lab' title='Sinatra Basic Forms Lab'>Sinatra Basic Forms Lab</a> on Learn.co and start learning to code for free.</p>

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/sinatra-basic-forms-lab'>Sinatra Basic Forms Lab</a> on Learn.co and start learning to code for free.</p>

<p class='util--hide'>View <a href='https://learn.co/lessons/sinatra-basic-forms-lab'>Sinatra Basic Forms Lab</a> on Learn.co and start learning to code for free.</p>
