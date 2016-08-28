# WeatherJudge

This gem retrieves weather forecasting data from Forecast.IO via [forecast-ruby](https://github.com/darkskyapp/forecast-ruby) and returns an overall score, for the following aspects of weather forecast. The total score can be between 0 and 100. Currently it only evaluates today's data but I plan on adding ability to take a specified date.
- Temperature
- Sky Cover
- Wind speed
- Change of Rain

This gem was originally developed to be used in my personal project for ranking overall weather of different locations, but feel free to use it for any purpose.  


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
`WeatherJudge` returns overall weather score, and scores of weather aspect.

```ruby
data = WeatherJudege.run(44, -122)
data.total_location_score
# returns a score of 0 - 100
```

Available methods for `WeatherData`
- `raw_data`
- `total_location_score`
- `cloud_cover_score`
- `wind_score`
- `temperature_score`
- `percent_rain_score`



## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Future Plans
The currently state of gem is more of a proof of concept. This gem will very likely to evolve in the future. A coulple of obvious future plans are:
 - Add ability to change preferred weather aspects for scoring
 - Add ability to specify a date for retrieving scored data

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/weather_judge.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

