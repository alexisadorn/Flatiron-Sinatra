# Sinatra Basic Sessions Lab

Session cookies allow a website to keep track of your movements and information from page to page for a single session (log in time to log out time). As soon as you log out, the cookie expires and the browser loses the data.

Server side, you set up a session, and the information from that session is stored in the browser by way of a cookie.

The goal of this lab is to save a piece of data to the `session cookie`, and display that data in a view. 

Sessions are commonly used to store data for online shopping. In this lab, you'll be storing an item a user is buying from page to page.

## Instructions

You'll be coding your solution in both `app.rb` and `views`.

1. Make sure you enable sessions in `app.rb` and set a `session_secret`.

2. Set up a controller action that responds to a GET request to the route `'/'`. You'll want this action to render an erb file,` index.erb`.

3. `index.erb` should contain a form with text field. Here, the user will enter an item to purchase. The form should post to the action `/checkout`.

4. The controller action  `/checkout`, should take the params from the form and add it to the session hash. The key should be `item` and the value should be the item the user entered to the purchase. Make sure to store the session hash in an instance variable that you can access in the views.

5. In the view rendered by the controller action, display the item the user entered to purchase.

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/sinatra-basic-sessions-lab' title='Sinatra Basic Sessions Lab'>Sinatra Basic Sessions Lab</a> on Learn.co and start learning to code for free.</p>
