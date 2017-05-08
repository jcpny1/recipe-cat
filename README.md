# RECIPE-CAT

<!-- <img src="https://raw.github.com/jcpny1/recipe-cat/master/app/assets/images/recipe-cat.jpg" alt="Recipe-Cat Logo" width="10%" height="10%"/> -->

<!-- ![Recipe-Cat Logo](https://raw.github.com/jcpny1/recipe-cat/master/app/assets/images/recipe-cat.jpg) -->
<!-- By [Plataformatec](http://plataformatec.com.br/). -->

[![Build Status](https://api.travis-ci.org/jcpny1/recipe-cat.svg?branch=master)](http://travis-ci.org/jcpny1/recipe-cat)
[![Code Climate](https://codeclimate.com/github/jcpny1/recipe-cat.svg)](https://codeclimate.com/github/jcpny1/recipe-cat)
<!-- [![Dependency Status](https://gemnasium.com/jcpny1/recipe-cat.svg)][Dependencies] -->
[![Inline docs](http://inch-ci.org/github/jcpny1/recipe-cat.svg)](http://inch-ci.org/github/jcpny1/recipe-cat)

<!-- This README is [also available in a friendly navigable format](http://devise.plataformatec.com.br/). -->

Recipe-Cat is a Rails-based recipe catalog application.

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


Keeps a repository of recipes. The user can view all recipes, search recipes by ingredient, favorite a recipe, and comment on a recipe.
This application was created to meet the requirements of the learn.co Rails portfolio project.

```
0.1.1  Initial release.  
0.1.2  Improved column display formatting.  
0.1.3  Improved use of Nokogiri methods.  
0.1.4  Fix scrape bug introduced in 0.1.3.  
       Display invalid input message if user enters item number 0.  
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'classifieds-cli-app'
```

And then execute:

  `$ bundle`

Or install it yourself as:

  `$ gem install classifieds-cli-app`

## Usage

  `$ classifieds`

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jcpny1/classifieds-cli-app. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
