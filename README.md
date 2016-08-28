# WeatherJudge

This gem retrieves weather forecasting data from Forecast.IO via [forecast-ruby](https://github.com/darkskyapp/forecast-ruby) and returns an overall score, using the following.
- Temperature
- Sky Cover
- Wind speed
- Change of Rain

This gem was originally developed to be used in my personal project for ranking weather of different locations, but feel free to use it for any purpose.  


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'weather_judge'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install weather_judge

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/weather_judge.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

