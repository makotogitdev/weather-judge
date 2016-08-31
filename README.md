# WeatherJudge

This gem retrieves weather forecasting data from Forecast.IO via [forecast-ruby](https://github.com/darkskyapp/forecast-ruby) 
using longitude and latitude and returns an overall score. The following criteria are used to judge
the quality of weather. The maximum score you can get is 100. 

- Temperature
- Sky Cover
- Wind speed
- Chance of Rain

Currently it only evaluates today's data but I plan on adding an ability to take a specified date. This is 
more of a proof of concept at this point. Since there are four criteria, each criteria can be given
up to 25 points. Optimal weather is considered as a day with comfortable temperature (67-77F), less than 15 mph wind, 
low chance of rain, and low sky cover.

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

Please see [Forecast IO's documentation](https://developer.forecast.io/) for creating an api key. 

```ruby
WeatherJudge.forecast_io_api_key = '(your api key here)'
data = WeatherJudge.run(44, -122)
# => Returns `WeatherData` object

data.total_location_score
# => returns a score of 0 - 100
```

Available methods for `WeatherData`
- `raw_data`
- `total_location_score`
- `cloud_cover_score`
- `wind_score`
- `temperature_score`
- `percent_rain_score`



## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for 
an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, 
update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a 
git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Future Plans/Disclaimer
This gem was originally developed to be used in my personal project for ranking overall weather of 
different locations, but feel free to use it for any other purpose. This gem will be evolving in the 
near future. A couple of obvious future plans are:
 - Add ability to change preferred weather aspects for scoring
 - Add ability to specify a date for retrieving scored data

## Contributing
 
Bugs and pull requests are welcome, but if you want to make significant changes, please fork this project 
and make changes there until you are satisfied, and then create a pull request. Please remember to add
tests. :)

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Copyright
Copyright (c) 2016 Makoto Scott-Hinkle. Please see LICENSE.txt for details.