# Gmapsderails

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/gmapderails`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gmapsderails'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gmapsderails

    $ rails generate gmapsderails:install


## Usage

1) Javascript

    <%= yield :scripts %> (in your footer)

2) model
    add:

    acts_as_gmappable

    migration: 

    [example (model -> user)]
    add_column :users, :latitude,  :float
    add_column :users, :longitude, :float
    add_column :users, :gmaps, :boolean 

3) controller
    [example (model -> user)]
    @json = User.all.to_gmapsderails

4) view

    <%= gmapsderails(@json) %>

    or 

    <%= gmapsderails(@json,[css_name]) %> #css_name is added to gmapsderails.css 


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/gmapsderails/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
