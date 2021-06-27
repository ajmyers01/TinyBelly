# TinyBelly
Coding Kata for GoldBelly.com

---
### Requirements

#### URL Shortener: Back End

Your task is to build the back end of a web service for shortening URLs. This will be an API service that a client would communicate with. The deliverable is the source code, written in Ruby, using whichever libraries, tools, database(s), and development methodologies you choose.

The requirements intentionally leave out many details. This is an opportunity for you to make decisions about the design of the service. What you leave out is just as important as what you include!

Product Requirements:
- Clients should be able to create a shortened URL from a longer URL.
- Clients should be able to specify a custom slug.
- Clients should be able to expire / delete previous URLs.
- Users should be able to open the URL and get redirected.

Project Requirements:
- The project should include an automated test suite.
- The project should include a README file with instructions for running the web service and its tests. You should also use the README to provide context on choices   made during development.
- The project should be packaged as a zip file or submitted via a hosted git platform (Github, Gitlab, etc).

---


# Install

## Dependencies

- [direnv](https://direnv.net/docs/installation.html)
- Docker

# Usage

## Environment Variables

| name | usage |
| ---- | ----- |
| POSTGRES_HOST | Hostname for the postgres instance. |
| POSTGRES_USER | User to login to postgres. |
| POSTGRES_PASSWORD | Password to login to postgres. |
| PRIMARY_EMAIL | Email address used to login to the rails app in development. |
| PRIMARY_PASSWORD | Password used to login to the rails app in development. |
| RAILS_MAX_THREADS | How many threads to run in the app and sidekiq. |
| REDIS_URL | Url used to connect to redis. |
| SUPER_SECRET | JWT encode/decode secret |

## Getting Started

Create and modify the `.envrc.secrets` to have values for the secret vars documented in `.envrc`.

Run `direnv allow` to populate your environment with the env vars configured in `.envrc` and `.envrc.secrets`.

Run postgres and redis in the background:

```sh
docker-compose up -d postgres redis
```

Build the local docker image:

```sh
docker-compose build
```

Cache the ruby gems:

```sh
docker-compose run --rm app bundle install
```

Setup the database:

```sh
docker-compose run --rm app rails db:create db:migrate
```

Seed the database:

```sh
docker-compose run --rm app rails db:seed
```

Start the rails app:

```sh
docker-compose up app
```

Start sidekiq for background jobs:

```sh
docker-compose up sidekiq
```

Start webpack for the frontend:

```sh
docker-compose up webpack
```

Run the Test Suite

```sh
docker-compose run --rm app rake test
```

Postman collection Link

https://www.getpostman.com/collections/760cd485f08c1be61dec

You have to create a user, then add the token returned into headers.



## Reflection on choices 

I utilized a docker file from a personal project to cut down on time so that is why there are a few extra moving pieces. 
I chose to use JWT for my authorization across my API, and just Bcrypt for password encryption into the postgres database for the users. 
I added the end points required as well as a few that were useful for testing. 

I started out by writing out tables and relationships in my notebook as well as a few controller actions that I thought would be necessary. 
Then I generated my migrations and populated my database. For my development process I utilized Postman for api testing, eventually got around to writing minitests then followed that up with refactors of both. 

Things I could improve on:
  - Better validations on content of the original url, maybe test that they resolve. 
  - build a custom 404 page for if the url we redirect to is not valid, or the slug is no longer valid. I just used json for now. 
  - Test coverage could be more detailed when testing, not just testing one field or the object was created. 
