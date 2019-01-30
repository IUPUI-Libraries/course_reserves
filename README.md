# README

## Setting Up Demo / Prod Mode

* RAILS_ENV=production rake db:migrate
* RAILS_ENV=production bin/rails assets:precompile

## Creating admin account fro initial account
* user = User.find(1)
* admin = Role.new(name: 'admin')
* user.roles << admin

