# iCapital Identity – Partner Intake

A simple Rails 8 + Postgres web app that allows a partner to input investor data and upload at least one document per investor.  
Investor data is persisted to a relational database, and uploaded files are stored locally via Active Storage.
## Prerequisites
- Ruby 3.2+ (or 3.x)
- Rails 8
- PostgreSQL 13+
- macOS or Linux

## Setup
```bash
# Clone the repo
git clone git@github.com:kendallcarey/icapital-identity-portal.git
cd icapital-identity-portal

# Install dependencies
bundle install

# Setup database
bin/rails db:create db:migrate

# Start server
bin/rails s
```

## Usage

1. Navigate to `/signup` to create a new partner user.
2. Log in at `/login`.
3. Go to `/investors/new` to add an investor.
   - Required fields: first name, last name, DOB, phone, street, state, zip.
   - Must attach at least one file.
4. After saving, you’ll see the newly saved investor. You can navigate to the list of all investors or back to the form to create a new one.

## What I did
- Generated CRUD scaffolding for `Investor`.
- Configured Postgres as the database.
- Enabled file uploads with Active Storage, storing files on the local filesystem.
- Added Rails 8 authentication (`rails g authentication`).
- Wrapped investor creation/update in a transaction so documents + DB save succeed or fail together.

## If I had more time
- **Styling**: Add TailwindCSS or Bootstrap for a cleaner UI.
- **Address normalization**: Move address into a separate table (with history tracking).
- **Authentication polish**: Redirect `/` → login if unauthenticated, investors list if logged in.
- **SSN encryption**: I experimented with deterministic encryption to allow querying by SSN. I didn’t fully finish, but I left my attempts in comments to show approach.
- **Tests**: I prefer RSpec tests but the scaffoliding added decent tests.
- **File handling**: Add support for >3 MB files with progress indicator.

