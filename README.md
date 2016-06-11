# RailsCleaner

[![Stories in Ready](https://badge.waffle.io/harrim91/rails_cleaner.svg?label=ready&title=Ready)](http://waffle.io/harrim91/rails_cleaner)
[![Gem Version](https://badge.fury.io/rb/rails_cleaner.svg)](https://badge.fury.io/rb/rails_cleaner)


Tracks and deletes any unused auto-generated scss and coffeescript files from your rails project.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rails_cleaner'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rails_cleaner

## Usage

In your command line:

`rails_cleaner_init` creates a `.rails_cleaner` directory in your working directory, containing a `tracked_files.txt` file.
`rails_cleaner_track` adds all `.scss` and `.coffee` files in the `app/assets` directory to `tracked_files.txt`
`rails_cleaner_sort` creates `files_to_delete.txt` in `.rails_cleaner`. This contains all files from `tracked_files.txt` where the created time and last modified times are the same.
`rails_cleaner_delete` deletes all files listed in `files_to_delete.txt`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/harrim91/rails_cleaner.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

