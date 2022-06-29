![header image (railyard)](docs/images/cover-image.png?raw=true "Photo by Maxim Melnikov on Unsplash")

# Railyard

Do you think the steps involved in building a Rails application development environment with Docker are too complicated?

The `railyard` command solves this for you.

The `railyard` command prepares the specified `Gemfile` template.
It will prepare a `Dockerfile` or `docker-compose.yml` depending on the specified DBMS.
Then, it runs `rails new` and gets you ready to start development right away.
It takes about a minute.

## Installation

The installation process is as follows

    $ gem install railyard

## Usage

```
Usage:
  railyard generate [NAME]

Options:
  [--ruby-version=RUBY_VERSION]      # Ruby version (docker image tag)
                                     # Default: latest
  [--db=DB]
                                     # Default: mysql
                                     # Possible values: mysql, postgresql
  [--skip-build], [--no-skip-build]  # Skip build
  [--force]                          # Force to execute
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/snaka/railyard.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
