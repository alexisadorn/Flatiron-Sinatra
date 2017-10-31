
## Sinatra ActiveRecord CRUD

1. Implement all four CRUD actions in a Sinatra application.
2. Understand how each CRUD action corresponds to a controller action and POST request.

## Instructions

We've had a lot of practice with the ActiveRecord CRUD actions, so now it's time to tie them to controller actions in a Sinatra application. In this lab, you'll be building a basic blog post app, using every CRUD action.

**Important:** In Sinatra, the order in which you define your routes in a controller matters. Routes are matched in the order they are defined. So, if we were to define the `get '/posts/:id'` route *before* the `get 'posts/new'` route, Sinatra would feed all requests for `posts/new` to the `posts/:id` route and we should see an error telling us that your app is unable to find a `Post` instance with an `id` of `"new"`. The takeaway is that you should define your `/new` route *before* your `/posts/:id` route.

### Database

First, you'll need to create the `posts` table. A blog post should have a name and content.

Next, set up the corresponding `Post` model. Make sure the class inherits from `ActiveRecord::Base`.

### Create

Now that we have the database and model set up, it's time to set up the ability to create a blog post.

First, create a route in your controller, `get '/posts/new'`, that renders the `new.erb` view.

We need to create an erb file in the views directory, `new.erb`, with a form that POSTs to a controller action, `/posts`. The controller action should use the Create CRUD action to create the blog post and save it to the database. Then, the action uses `erb` to render the index view page.

### Read

The Read CRUD action corresponds to two different controller actions: show and index. The show action should render the erb view `show.erb`, which shows an individual post. The index action should render the erb view `index.erb`, which shows a list of *all* of the posts.

Create the `get '/posts'` controller action. This action should use Active Record to grab *all* of the posts and store them in an instance variable, `@posts`. Then, it should render the `index.erb` view. That view should use erb to iterate over `@posts` and render them on the page.

Create the `get '/posts/:id'` controller action. This action should use Active Record to grab the post with the `id` that is in the params and set it equal to `@post`. Then, it should render the `show.erb` view page. That view should use erb to render the `@post`'s title and content.


### Update

The Update CRUD action corresponds to the edit controller action and view.

Create a controller action, `get '/posts/:id/edit'`, that renders the view, `edit.erb`. This view should contain a form to update a specific blog post and POSTs to a controller action, `patch '/posts/:id'`.

You'll need to make sure the edit form includes:

```html
<input id="hidden" type="hidden" name="_method" value="patch">
```

**Reminder:** Remember to add the `use Rack::MethodOverride` to your `config.ru` file so that your app will know how to handle `patch` and `delete` requests!

### Delete

The Delete CRUD action corresponds to the delete controller action, `delete '/posts/:id/delete'`. To initiate this action, we'll just add a "delete button" to the show page. This "button" will actually be a form, disguised as a button (intriguing, I know). The form will send a POST request to the delete controller action, where we will identify the post to delete and delete it. Then, the action should render a `delete.erb` view which confirms that the post has been deleted.

#### Making our Delete "Button"

In order to make a form that looks like a button, all we need to do is make a form that has no input fields, only a "submit" button with a value of "delete". So, give your form tag a method of `"post"` and an action of `"/posts/:id/delete'`. Make sure to dynamically set the `:id` of the form action! You'll also need to make sure the form includes the hidden input tag to change the request from `post` to `delete`.
<p data-visibility='hidden'>View <a href='https://learn.co/lessons/sinatra-ar-crud-lab'>Sinatra ActiveRecord CRUD</a> on Learn.co and start learning to code for free.</p>

<p class='util--hide'>View <a href='https://learn.co/lessons/sinatra-ar-crud-lab'>Sinatra ActiveRecord CRUD</a> on Learn.co and start learning to code for free.</p>
