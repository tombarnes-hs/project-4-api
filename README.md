# Minventory

This app allow players of the [X-Wing Miniatures Game (1st Edition)](https://www.fantasyflightgames.com/en/products/x-wing/) from [Fantasy Flight Games](https://www.fantasyflightgames.com/en/index/) to manage their collections.

In it's current state users can simply CRUD their collection by using input fields. Users own a `Ships` resource on tne API to control what ships they own.

A future iteration of the site would allow users to view all available ships, pilots, upgrades, released sets and select whether or not they own them. That data, though not currently accessible via requests to an API, comes courtesy of [this repo](https://github.com/guidokessels/xwing-data).

[Deployed API](https://ancient-headland-25420.herokuapp.com/)

[Deployed Client](https://tomg84.github.io/project-4-client/#/)

[Client Repo](https://github.com/TomG84/project-4-client)

## Back-End Installation

1. Fork and Clone this repository.
2. Install dependencies with `bundle install`.
3. Run the development server with `npm start`.
4. Createa a .env to hold secret keys (`touch .env`)
5. Generate new development and test secrets (`bundle exec rails secret`) <= do twice.
6. Store tem in .env with keys `SECRET_KEY_BASE_<DEVELOPMENT|TEST>`respectively.
7. Set up a Heroku server.
8. set up your database with the following:
* `bin/rails db:drop`
* `bin/rails db:create`
* `bin/rails db:migrate`
* `bin/rails db:seed` (seeds the Sources resource from lib/sources)

9. Run the API server with `bin/rails server`


## Technologies Used

#### Front-End

* React
* Bootsrap via reactstrap
* Fetch for http requests to API for User Auth
* Axios for http requests to API for Ship resource
* JavaScript
* HTML5
* CSS3

#### Back-End

* Rails
* PostgreSQL
* Ruby

## Next Steps

The scope of this project is ambitious and I have a long way to go. Below is a list of things I'd like to do with this app:

1. The API currently has a resources, `Sources`, that has been seeded from the data store. I haven't had time to make that the primary resource the user owns.

2. Replace manual/text input from the user with a list of available ships that is populated from the API.

3. Create Pilots, Ships, and Collections resources to expand user ownership and create an app that closely reflects a user's actual collection.

4. Incorporate a way for users to store information about squads they've used at tournaments based off of their collection

## Planning and Problem-Solving

#### Entity Relationship

![ERD](https://i.imgur.com/dN6Mwjn.jpg)

User has many Ships.
Ships belong to User.



Planning for this was difficult. React proved a tricky framework to wrap my head around and it had a big impact on my timeline.

My plan for this project was to build a version 1 that included a backend API in which a user owned a resource for ships. They would CRUD this resource by simply typing inputs from the client.

Once that was done I planned to add another resource and seed it with data from the X-Wing data collection with no relationships. After a user could CRUD on that resource (which would replace the version 1 resource), I would add more resources and create relationships between the resources.

In the 8 days I was able to:

1. Build the version 1 API with Rails.
2. Build the version 1 client with React.
3. Seed a version 2 database
4. Debug version 1

Problems encountered along the way mainly had to do with setting up routes for components. Passing data from component-to-component was a big challenge. I would often get stuck trying combinations of `this.props.that.that.x.y` or `this.state.a.b.c` over and over. I would only get out of this cycle by erasing a lot of code and writing it out meticulously.

I had a similar problem seeding the database for the version 2 resource. I'd never done that before and the data collection was huge.

Most errors in this problem came from wanting to get version 1 done quickly so I could attempt version 2 before the end of the project week. As a result of looking for shortcuts I made many mistakes that I would not have made had I been more meticulous and slow.


## API

See below for a list of routes and curl-scripts to test built-in actions.

### Authentication

| Verb   | URI Pattern            | Controller#Action |
|--------|------------------------|-------------------|
| POST   | `/sign-up`             | `users#signup`    |
| POST   | `/sign-in`             | `users#signin`    |
| PATCH  | `/change-password`     | `users#changepw`  |
| DELETE | `/sign-out`        | `users#signout`   |

#### POST /sign-up

Request:

```sh
curl http://localhost:4741/sign-up \
  --include \
  --request POST \
  --header "Content-Type: application/json" \
  --data '{
    "credentials": {
      "email": "'"${EMAIL}"'",
      "password": "'"${PASSWORD}"'",
      "password_confirmation": "'"${PASSWORD}"'"
    }
  }'
```

```sh
EMAIL=ava@bob.com PASSWORD=hannah curl-scripts/auth/sign-up.sh
```

Response:

```md
HTTP/1.1 201 Created
Content-Type: application/json; charset=utf-8

{
  "user": {
    "id": 1,
    "email": "ava@bob.com"
  }
}
```

#### POST /sign-in

Request:

```sh
curl http://localhost:4741/sign-in \
  --include \
  --request POST \
  --header "Content-Type: application/json" \
  --data '{
    "credentials": {
      "email": "'"${EMAIL}"'",
      "password": "'"${PASSWORD}"'"
    }
  }'
```

```sh
EMAIL=ava@bob.com PASSWORD=hannah curl-scripts/auth/sign-in.sh
```

Response:

```md
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8

{
  "user": {
    "id": 1,
    "email": "ava@bob.com",
    "token": "BAhJIiVlZDIwZTMzMzQzODg5NTBmYjZlNjRlZDZlNzYxYzU2ZAY6BkVG--7e7f77f974edcf5e4887b56918f34cd9fe293b9f"
  }
}
```

#### PATCH /change-password

Request:

```sh
curl --include --request PATCH "http://localhost:4741/change-password" \
  --header "Authorization: Token token=$TOKEN" \
  --header "Content-Type: application/json" \
  --data '{
    "passwords": {
      "old": "'"${OLDPW}"'",
      "new": "'"${NEWPW}"'"
    }
  }'
```

```sh
OLDPW='hannah' NEWPW='elle' TOKEN='BAhJIiVlZDIwZTMzMzQzODg5NTBmYjZlNjRlZDZlNzYxYzU2ZAY6BkVG--7e7f77f974edcf5e4887b56918f34cd9fe293b9f' sh curl-scripts/auth/change-password.sh
```

Response:

```md
HTTP/1.1 204 No Content
```

#### DELETE /sign-out

Request:

```sh
curl http://localhost:4741/sign-out \
  --include \
  --request DELETE \
  --header "Authorization: Token token=$TOKEN"
```

```sh
TOKEN='BAhJIiVlZDIwZTMzMzQzODg5NTBmYjZlNjRlZDZlNzYxYzU2ZAY6BkVG--7e7f77f974edcf5e4887b56918f34cd9fe293b9f' sh curl-scripts/auth/sign-out.sh
```

Response:

```md
HTTP/1.1 204 No Content
```

### Users

| Verb | URI Pattern | Controller#Action |
|------|-------------|-------------------|
| GET  | `/users`    | `users#index`     |
| GET  | `/users/1`  | `users#show`      |
| PATCH| `/users/1`  | `users#update`    |

#### GET /users

Request:

```sh
curl http://localhost:4741/users \
  --include \
  --request GET \
  --header "Authorization: Token token=$TOKEN"
```

```sh
TOKEN=BAhJIiVlZDIwZTMzMzQzODg5NTBmYjZlNjRlZDZlNzYxYzU2ZAY6BkVG--7e7f77f974edcf5e4887b56918f34cd9fe293b9f curl-scripts/users.sh
```

Response:

```md
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8

{
  "users": [
    {
      "id": 2,
      "email": "bob@ava.com"
    },
    {
      "id": 1,
      "email": "ava@bob.com"
    }
  ]
}
```

#### GET /users/:id

Request:

```sh
curl --include --request GET http://localhost:4741/users/$ID \
  --header "Authorization: Token token=$TOKEN"
```

```sh
ID=2 TOKEN=BAhJIiVlZDIwZTMzMzQzODg5NTBmYjZlNjRlZDZlNzYxYzU2ZAY6BkVG--7e7f77f974edcf5e4887b56918f34cd9fe293b9f curl-scripts/user.sh
```

Response:

```md
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8

{
  "user": {
    "id": 2,
    "email": "bob@ava.com"
  }
}
```

#### PATCH /users/:id

Request:

```sh
curl "http://localhost:4741/users/${ID}" \
  --include \
  --request PATCH \
  --header "Authorization: Token token=${TOKEN}" \
  --header "Content-Type: application/json" \
  --data '{
    "user": {
      "email": "'"${EMAIL}"'"
    }
  }'
```

```sh
ID=1 TOKEN="BAhJIiU1NGNlYjRmMjBhM2NkZTZiNzk1MGNiYmZiYWMyY2U4MwY6BkVG--ddb1e16af0e05921aa56d771e4a2f816f2a1d46e"
EMAIL=mike@m
sh curl-scripts/users/user-update.sh
```

Response:

```md
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8

{"user":{"id":1,"email":"mike@m"}}
```

### Reset Database without dropping

This is not a task developers should run often, but it is sometimes necessary.

**locally**

```sh
bin/rails db:migrate VERSION=0
bin/rails db:migrate db:seed db:examples
```

**heroku**

```sh
heroku run rails db:migrate VERSION=0
heroku run rails db:migrate db:seed db:examples
```

### Ships

| Verb   | URI Pattern            | Controller#Action |
|--------|------------------------|-------------------|
| POST   | `/ships`             | `ships#create`    |
| INDEX   | `/ships`             | `ships#all`    |
| GET   | `/ships/:id`        |  `ships#show` |
| PATCH  | `/ships/:id/update`     | `ships#update`  |
| DELETE | `/ships/:id`        | `ships#destroy`   |

#### POST /ships

Request:

```sh
curl 'http://localhost:4741/ships' \
  --include \
  --request POST \
  --header "Content-Type: application/json" \
  --header "Authorization: Token token=${TOKEN}" \
  --data '{
    "ship": {
      "name": "'"${NAME}"'",
      "pilot": "'"${PILOT}"'",
      "notes": "'"${NOTES}"'"
    }
  }'
```

```sh
TOKEN='BAhJIiVlZDIwZTMzMzQzODg5NTBmYjZlNjRlZDZlNzYxYzU2ZAY6BkVG--7e7f77f974edcf5e4887b56918f34cd9fe293b9f'
NAME='X=Wing' PILOT='Luke Skywalker' NOTES='Blew up Death Star' curl-scripts/ships/create.sh
```

Response:

```md
HTTP/1.1 201 Created
Content-Type: application/json; charset=utf-8

{
  "ship": {
    "name": "X-Wing",
    "pilot": "Luke Skywalker"
    "notes": "Blew up Death Star"
  }
  "user": {
    "id": 0,
    "email": "ava@bob"
  }
}
```

#### DELETE /ships/:id

Request:

```sh
curl "http://localhost:4741/ships/${ID}" \
  --include \
  --request DELETE \
  --header "Authorization: Token token=${TOKEN}" \
```

```sh
TOKEN='BAhJIiVlZDIwZTMzMzQzODg5NTBmYjZlNjRlZDZlNzYxYzU2ZAY6BkVG--7e7f77f974edcf5e4887b56918f34cd9fe293b9f' sh curl-scripts/ships/destroy.sh
```

Response:

```md
HTTP/1.1 204 No Content
```

### Ships

| Verb | URI Pattern | Controller#Action |
|------|-------------|-------------------|
| GET  | `/ships`    | `ships#index`     |
| GET  | `/ships/1`  | `ships#show`      |
| PATCH| `/ships/1`  | `ships#update`    |

#### GET /ships

Request:

```sh
curl "http://localhost:4741/ships" \
  --include \
  --request GET \
  --header "Authorization: Token token=${TOKEN}"

```

```sh
TOKEN=BAhJIiVlZDIwZTMzMzQzODg5NTBmYjZlNjRlZDZlNzYxYzU2ZAY6BkVG--7e7f77f974edcf5e4887b56918f34cd9fe293b9f curl-scripts/ships/index.sh
```

Response:

```md
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8

{
  "ships": [
    {
      "id": 2,
      "name": "X-Wing",
      "pilot": "Wedge Antilles",
      "notes": "Blew up second Death Star"
    },
    {
      "id": 1,
      "name": "T-70 X-Wing",
      "pilot": "Poe Dameron",
      "notes": "Blew up third Death Star"
    }
  ]
}
```

#### GET /ships/:id

Request:

```sh
curl "http://localhost:4741/ships/${ID}" \
  --include \
  --request GET \
  --header "Authorization: Token token=${TOKEN}"
```

```sh
ID=2 TOKEN=BAhJIiVlZDIwZTMzMzQzODg5NTBmYjZlNjRlZDZlNzYxYzU2ZAY6BkVG--7e7f77f974edcf5e4887b56918f34cd9fe293b9f ID=1 sh curl-scripts/ships/show.sh
```

Response:

```md
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8

{
  "ship": {
    "id": 2,
    "name": "X-Wing",
    "pilot": "Wedge Antilles",
    "notes": "Blew up second Death Star"
  }
}
```

#### PATCH /ships/:id

Request:

```sh
curl "http://localhost:4741/ships/${ID}" \
  --include \
  --request PATCH \
  --header "Content-Type: application/json" \
  --header "Authorization: Token token=${TOKEN}" \
  --data '{
    "ship": {
      "pilot": "'"${PILOT}"'",
      "notes": "'"${NOTES}"'"
    }
  }'
```

```sh
ID=1 TOKEN="BAhJIiU1NGNlYjRmMjBhM2NkZTZiNzk1MGNiYmZiYWMyY2U4MwY6BkVG--ddb1e16af0e05921aa56d771e4a2f816f2a1d46e"
PILOT="Jek Porkins" NOTES="No, I'm alright...(explosion)"
sh curl-scripts/ships/update.sh
```

Response:

```md
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8

{"ship": {
  "id":1,
  "name":"X-Wing",
  "pilot": "Jek Porkins",
  "notes": "No, I'm alright...(explosion)"
  }
}
```
