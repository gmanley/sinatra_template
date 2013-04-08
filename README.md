Sinatra Template
================

My base Sinatra template, with support for active_record or mongoid (Checkout the other branches).

* Clone it
* Rename 'config/config.yml.example'
* `bundle install`
* `script/server` to start the development server.
* `script/console` to start console
* `RACK_ENV=test rake db:migrate spec` to run tests

Feel free to fork it, clone it or otherwise modify it for your own use.

Includes a basic authentication system.

Setup with:
------
* Mongoid or ActiveRecord
* HAML
* Twitter Bootstrap

__Requirements:__

* Ruby (>= 1.9.2)
* MongoDB or any active_record supported db
* Bundler
