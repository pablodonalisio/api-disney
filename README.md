# README

This is a Disney API where you can storage Disney characters and films to a database. Also you can
see which character participate on which in film, add films genres and more.

You can test it at https://api-disney.herokuapp.com

# Ruby version

`ruby '2.7.3'`

# Configuration

To get a local copy of the API clone the repo with

`git clone git@github.com:pablodonalisio/api-disney.git`

and install dependencies with

`bundle install`

and you're good to go.

# Usage

To start using the API you need to create a user.

You can create one at

`POST /users`

Query params:

- user[email]
- user[password] (min 6 characters)

Then you need to login to get a Token at

`POST /login`

Query params:

- user[email]
- user[password]

You need the token to make requests to the API.

# Endpoints

To make request to the endpoints you need to add an Authorization header to the HTTP request
like this

`Authorization: Bearer <YourApiToken>`

## Characters

### POST /characters

Allows you to create a Disney character.

Query params:

- character[name] (requiered)
- character[image_url]
- character[weight]
- character[age]
- character[story]

### PATCH /characters/:characterId

Allows you to update a Disney character.

Query params:

- character[name]
- character[image_url]
- character[weight]
- character[age]
- character[story]

### GET /characters

Gives you a list of all characters.

To get a single chararacter with all his attributes and films
pass the name as a parameter like this

`GET /characters?name=characterName`

Also you can filter characters using this query params:

- age
- weight

### DELETE /characters/:characterId

Delete a character.

## Genre

### POST /genre

Allows you to create a film genre.

Query params:

- genre[name] (requiered)
- genre[image_url]

### PATCH /genres/:genreId

Allows you to update a film genre.

Query params:

- genre[name] (requiered)
- genre[image_url]

### GET /genres

Gives you a list of all genres.

### DELETE /genres/:genreId

Delete a genre.

## Films

### POST /films

Allows you to create a Disney film.

Query params:

- film[title] (requiered)
- film[image_url]
- film[release_date]
- film[rating] (from 1 to 5)

You can also add characters to the film sending an array with the characters ids named characters_ids.

`characters_ids: []`

And the same works for genres.

`genres_ids: []`

### PATCH /films/:filmId

Allows you to update a Disney film.

Query params:

- film[title] (requiered)
- film[image_url]
- film[release_date]
- film[rating] (from 1 to 5)

You can add characters and genres justy like you do on a film creation.

### GET /films

Gives you a list of all films.

To get a single film with all its attributes, characters and genres
pass the title as a parameter like this

`GET /films?title=filmtitle`

Also you can filter films by genre passing it as a query param

`GET /films?genre=genreId`

You can get films ordered by release_date

`GET /films?order=ASC/DESC`

### DELETE /films/:filmId

Delete a film.

# Test suite

To run tests type

`bundle exec rspec`
