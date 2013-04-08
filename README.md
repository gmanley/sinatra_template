Sinatra Template
================

My base Sinatra template, with support for ActiveRecord.
For Mongoid support checkout the corresponding branch.

* Clone the repository
* Rename 'config/config.yml.example' & edit config as needed.
* `bundle`
* Create databases
* rake db:migrate
* `script/server` to start the development server.
* `script/console` to start console
* `RACK_ENV=test rake db:migrate spec` to run tests

Feel free to fork it, clone it or otherwise modify it for your own use.

Includes a basic authentication system.

Setup with:
------
* ActiveRecord or Mongoid
* HAML
* Twitter Bootstrap

__Requirements:__

* Ruby (>= 1.9.2)
* Any ActiveRecord supported db or MongoDB
* Bundler
