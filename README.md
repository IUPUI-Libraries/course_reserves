# README

## Setting Up Demo / Prod Mode

* RAILS_ENV=production rake db:migrate
* RAILS_ENV=production bin/rails assets:precompile

## Creating admin account fro initial account
* user = User.find(1)
* admin = Role.new(name: 'admin')
* user.roles << admin

## Clearing Database
* RAILS_ENV=production rake db:reset db:migrate DISABLE_DATABASE_ENVIRONMENT_CHECK=1

## Precompiling Assets
* RAILS_ENV=production bin/rails assets:precompile
* (NEW) RAILS_ENV=production RAILS_RELATIVE_URL_ROOT="/reserves" bundle exec rake assets:precompile //Required for tinymce
