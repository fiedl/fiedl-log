# Fiedl::Log

Simple colored output helper for ruby scripts.

## Usage

```ruby
# ~/some_ruby_script.rb
require 'fiedl/log'

log.head "Awesome script"
log.section "Checking dependencies"
log.info "Checking if all dependencies are met."
log.success "Ok"

log.section "Checking deprecations"
log.warning "This does not work much longer ..."

log.section "Checking other stuff"
log.error "This script does nothing, yet."
raise "This script does nothing, yet, sorry!"
```

![screenshot](https://github.com/fiedl/fiedl-log/raw/master/screenshots/Bildschirmfoto%202016-11-24%20um%2018.14.49.png)

### Manually defining a log instance

This gem defines `log` unless `log` is already defined. But, of course, you may manually instantiate it:

```ruby
# ~/some_ruby_script.rb
require 'fiedl/log'

$log = Fiedl::Log::Log.new
```

### Filtering content

```ruby
# ~/some_ruby_script.rb
require 'fiedl/log'

log.filter_out("my_secret_password")
```

This will filter out any occurance of "my_secret_password" and replace it by "[...]" in the output.

### Shell commands

Print a shell command, execute it and display the result:

```ruby
# ~/some_ruby_script.rb
require 'fiedl/log'

shell "whoami"
```

![screenshot](https://github.com/fiedl/fiedl-log/raw/master/screenshots/Bildschirmfoto%202016-11-24%20um%2018.15.47.png)

The `shell` command returns both the output of the stdin and the stderr.

To prevent the `shell` command from printing anything, use `verbose: false`:

```ruby
user = shell "whoami", verbose: false
```

### Logging variables

```ruby
# ~/some_ruby_script.rb
require 'fiedl/log'

foo = "bar"
log.variable foo, "foo"

options = {
  foo: 'bar'
}
log.configuration options
```

### Other helpers

Ensure that a certain file is present before continuing: If the file is missing, the error is logged and the script is stopped.

```ruby
# ~/some_ruby_script.rb
require 'fiedl/log'

log.ensure_file "$HOME/.zshrc"
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fiedl-log'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fiedl-log

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fiedl/fiedl-log.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

