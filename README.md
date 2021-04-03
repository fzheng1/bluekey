# README
help

If you actually manage to get this up and running please update the doc lmao

GEMS

tbh I don't know how to setup gem dependencies up I think it's just 'bundle install' from the project directory

DATABASE SETUP

step 1: download and startup postgres somwhere

Update 'config/database.yml' to point to your own postgres instance since we don't have one set up for everyone :')
guess everyone knows my ip now, default postgres port is 5432 so don't worry about that

if on windows and using rails through wsl, host should be THE IP ADDRESS OF WHICHEVER SIDE YOU SET UP THE POSTGRES SERVER ON 
eg wsl postgres server -> wsl ip address (localhost might work)
eg windows postgres server -> windows ip address (localhost won't work)

if on windows and rails not in wsl can't help you sry

if on some unix env, I've no idea my setup is scuffed, but localhost should work

to start server locally run 'rails s' from project directory, available on localhost:3000 by default

* Ruby version
ruby 3.0.0p0 (2020-12-25 revision 95aff21468) [x86_64-linux]

* Rails version
Rails 6.1.3.1

* System dependencies
no clue

* Configuration
no clue

* Database creation
postgres

* Database initialization
rake db:create

* How to run the test suite
what are tests

* Services (job queues, cache servers, search engines, etc.)
'rails s' for api

* Deployment instructions
not my job

