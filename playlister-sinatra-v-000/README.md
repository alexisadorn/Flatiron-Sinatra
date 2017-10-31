# Sinatra Playlister

##Objectives

* Solidify your ActiveRecord understanding
* Build out basic views for all your models
* Create forms for editing and creating a new song that returns a well-structured params hash


### Overview

In the theme of moving from a simple command line application static website to dynamic web app, it's time to move Playlister to the interwebs using Sinatra. In this lab, you'll be:

  1. Giving our "library" of songs a dynamic web interface
  2. Creating a few complex forms that allow you to create and edit Artists, Songs and Genres.

## File Structure

Your application should use the following file structure. Notice how there are separate controllers for songs, artists, and genres. Separately, we have sub-directories for views for songs, artists, and genres.

```
├── app
│   ├── controllers
│   │   ├── application_controller.rb
│   │   ├── artists_controller.rb
│   │   ├── genres_controller.rb
│   │   └── songs_controller.rb
│   ├── models
│   │   ├── artist.rb
│   │   ├── concerns
│   │   │   └── slugifiable.rb
│   │   ├── genre.rb
│   │   ├── song.rb
│   │   └── song_genre.rb
│   └── views
│       ├── artists
│       │   ├── index.erb
│       │   └── show.erb
│       ├── genres
│       │   ├── index.erb
│       │   └── show.erb
│       ├── index.erb
│       ├── layout.erb
│       └── songs
│           ├── edit.erb
│           ├── index.erb
│           ├── new.erb
│           └── show.erb

```

### Instructions

The first thing you should aim to do is create a Sinatra interface for the data in `db/data`. There is a `LibraryParser` class included in the `lib` folder that you may use, though it may need some tweaking to work with your specific application. Your associations should follow this pattern:

1. An Artist can have multiple songs and multiple genres
2. A Genre can have multiple artists and multiple songs
3. A Song can belong to ONE Artist and multiple genres
4. How would we implement the relationship of a song having many genres and genre having many songs? In order to establish a "many-to-many" relationship, we'll need a join table. You will need a `SongGenre` class to go along with this table in the database

You should build the following routes:

1. `/songs`
  * This should present the user with a list of all songs in the library.
  * Each song should be a clickable link to that particular song's show page.
2. `/genres`
  * This should present the user with a list of all genres in the library.
  * Each genre should be a clickable link to that particular genre's show page.
3. `/artists`
  * This should present the user with a list of all artists in the library.
  * Each artist should be a clickable link to that particular artist's show page.
4. `/songs/:slug`
  * Any given song's show page should have links to that song's artist and the each genre associated with the song.
  * Pay attention to the order of `/songs/new` and `/songs/:slug`. The route `/songs/new` could interpret `new` as a slug if that controller action isn't defined first.
5. `/artists/:slug`
  * Any given artist's show page should have links to each of his or her songs and genres.
6. `/genres/:slug`
  * Any given genre's show page should have links to each of its artists and songs.

To get the data into your database, you will want to figure out how to use your `LibraryParser` class in the `db/seeds.rb` file.


### How to approach this lab

Get the basics of the app working first, which means we have five specs in total and you should first pass all three model specs.

By typing

```bash
rspec spec/models/01_artist_spec.rb
```

in your bash/ command line you will only run that spec. It is important to run the specs in their numeric order. You will notice even after adding a table, model, and controller your specs are still not passing, but the error messages are changing. You have to read every error message carefully to understand what to do next.

For the last spec `05_song_form_spec.rb` you need to implement the following features:

1. `/songs/new`
  * Be able to create a new song
  * Genres should be presented as checkboxes
  * Be able to enter the Artist's name in a text field (only one Artist per song.)
2. `/songs/:slug/edit`
  * Be able to change everything about a song, including the genres associated with it and its artist.

Think about the custom writer or writers you may need to write to make these features work.

### Slugs

Having a URL like `/songs/1` sort of sucks. Imagine trying to email that song to a friend. They would literally have no idea what the song would be until they click the link. You could be sending them literally anything. It would be much better to have a URL like `/songs/hot line bling`.

But again, we run into a problem here. We can't have spaces in a URL. In order to make it a proper URL, we have to convert the spaces to `-` in the song name. This is called a slug.

You are going to need to create some slugs in this lab. A slug is used to create a name that is not acceptable as a URL for various reasons (special characters, spaces, etc). This is great because instead of having a route like `/songs/1`, you can have a route `/songs/hotline-bling` which is a much more descriptive route name.

Each class you build will need to have a method to slugify each object's name. This means you'll need to strip out any special characters, and replace all spaces with `-`.

You'll need to build a method `slug` which takes a given song/artist/genre name and create the "slugified" version.

The `find_by_slug` method should use the `slug` method to retrieve a song/artist/genre from the database and return that entry.

## Check Boxes

In order to create a check box of all the genres on a new song form, you'll need to iterate over all the Genres in the database. From there, you'll want to set the genre name as the ID of the input tag.

The value attribute should be set to the genre id.

The name attribute should be set to set to `genres[]` because we're dealing with a collection of attributes. This will make the params hash look like this:

```ruby
params = {
  genres => [ genre1, genre2, genre2]
}
```

```html
<% Genre.all.each do |genre| %>
  <input id="<%= genre.name %>" type="checkbox" name="genres[]" value="<%= genre.id %>">
<% end %>
```

## Flash Message

You can add a flash message for when a new instance is created. Let's take a new song creation as an example.

First, add `gem 'rack-flash3'` to the Gemfile; run `bundle` to install it.

You can see in Rack Flash's [Sinatra](https://github.com/treeder/rack-flash#sinatra)
section the basics for getting flash messages working with Sinatra.

(Note: You'll need to `enable :sessions` for your application and `use Rack::Flash`
in the appropriate controller.)

You'll want to add a flash message to the `post '/songs'` and
`patch '/songs/:slug'` actions. `post '/songs'` might look something like:

```ruby
post '/songs' do
  # ...
  # ^ code for creating and saving a new song
  flash[:message] = "Successfully created song."
  redirect to("/songs/#{@song.slug}")
end
```

To display this message in the view, just add

```html
<!-- views/songs/show.erb -->

<% if flash.has?(:message) %>
  <%= flash[:message] %>
<% end %>
```

to the top of the view.

## A Note on the Database

Remember too that you can drop and recreate your database as much as you need
to. If you hit a jam, just reset the db, run migrations, and pick up where you
left off.

### Resources
* [Clean URL - Slugs](http://en.wikipedia.org/wiki/Slug_(web_publishing)#Slug)

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/playlister-sinatra' title='Sinatra Playlister'>Sinatra Playlister</a> on Learn.co and start learning to code for free.</p>
