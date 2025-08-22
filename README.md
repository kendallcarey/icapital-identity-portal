# iCapital Identity – Partner Intake

Rails + Postgres app to intake investor data and upload documents to local filesystem via Active Storage.

## Prerequisites
- Ruby 3.2+ (or 3.x)
- Rails 8
- PostgreSQL 13+
- macOS or Linux

## Setup
```bash
git clone git@github.com:kendallcarey/icapital-identity-portal.git
cd identity_portal
bundle install
bin/rails db:create db:migrate
bin/rails s
```

## What I did
With rails built in scaffolding generation, I was able to quickly create a CRUD app.
I was also able to quickly add authentication with Rails 8 new command `rails g authentication`, and it generates all the controllers, views, services, etc for you.

## If I had more time
I would make address a separate table.
I would add better styling

