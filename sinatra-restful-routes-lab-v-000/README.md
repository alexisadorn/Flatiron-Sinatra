# Restful Routes Basic Lab

## Objectives

1. Build RESTful routes to create, show, edit, and delete items from the database

## Instructions

Instead of keeping all your recipes on index cards (just like your grandma did!), we're going to be building a web app to store those recipes for you!

1.  Create a new table in the database to store the recipes. Recipes should have a `name`, `ingredients` (which can be written as one string containing all the ingredients), and `cook_time`.

2. Make sure you have a corresponding model for your recipes.

3. In the `application_controller.rb`, set up a controller action that will render a form to create a new recipe. This controller action should create and save this new recipe to the database.

4. Again in the `application_controller.rb`, create a controller action that uses RESTful routes to display a single recipe.

5. Create a third controller action that uses RESTful routes and renders a form to edit a single recipe. This controller action should update the entry in the database with the changes, and then redirect to the recipe show page

6. Create a controller action (index action) that displays all the recipes in the database.

7. Add to the recipe show page a form that allows a user to delete a recipe. This form should submit to a controller action that deletes the entry from the database and redirects to the index page.


<p data-visibility='hidden'>View <a href='https://learn.co/lessons/sinatra-restful-routes-lab' title='Restful Routes Basic Lab'>Restful Routes Basic Lab</a> on Learn.co and start learning to code for free.</p>
