# RECIPE-CAT

[![GitHub version](https://badge.fury.io/gh/jcpny1%2Frecipe-cat.svg)](https://badge.fury.io/gh/jcpny1%2Frecipte-cat)
[![Build Status](https://api.travis-ci.org/jcpny1/recipe-cat.svg?branch=master)](http://travis-ci.org/jcpny1/recipe-cat)
[![Test Coverage](https://codeclimate.com/github/jcpny1/recipe-cat/badges/coverage.svg)](https://codeclimate.com/github/jcpny1/recipe-cat/coverage)
[![Code Climate](https://codeclimate.com/github/jcpny1/recipe-cat/badges/gpa.svg)](https://codeclimate.com/github/jcpny1/recipe-cat)
[![Inline docs](http://inch-ci.org/github/jcpny1/recipe-cat.svg)](http://inch-ci.org/github/jcpny1/recipe-cat)

Recipe-Cat is a Rails-based recipe catalog application.

It was developed using Ruby v2.3.1.

The user can add recipes, view recipes, search recipes by ingredient, favorite a recipe, and comment on a recipe.

This application was created to meet the requirements of the learn.co Rails portfolio project.

```
12-Dec-20  Mitigate CVE-2015-9284.
10-Dec-20  Update Heroku stack from 16 to 20.
           Upgrade Ruby to 2.6.6 for Heroku requirement.
           Update Gemfile.lock. Update Heroku Postgres from 9 to 12.
19-Apr-18  Updated gems.
           Fixed typo on recipe author display.
14-Dec-17  Merged feature-js into master.
01-Aug-17  feature-js complete.
14-Jul-17  Branch feature-js created to meet the requirements of the learn.co
           "Rails App with a jQuery Front End" portfolio project.
08-May-17  Initial release.
```

## Installation and Usage

* Fork and clone the recipe-cat repository.
* Update config/initializers/devise.rb's config.secret_key or instead, for full functionality, create a config/secrets.yml file, to include
  - secret_key_base
  - facebook_key    (optional, for Facebook login ability)
  - facebook_secret (optional, for Facebook login ability)
* Execute bundle install.
* `rake db:migrate`
* `rake db:seed` (If you want to load test data.)
* Start a rails server, `rails s`.
* Connect to the rails server with a browser, `localhost:3000`.
* From there you can log in to the application for full functionality or browse the data as a guest.
* To run tests, `bundle exec rspec`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jcpny1/recipe-cat. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The application is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
