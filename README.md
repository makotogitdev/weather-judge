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
up to 25 points. By default, optimal weather is considered as a day with comfortable temperature (67-77F), less than 15 mph wind, 
low chance of rain, and low sky cover.

## Why I Developed This Gem

I currently live in Portland, OR, USA, where we have access to great outdoors. You can easily drive to the 
coast (Pacific Ocean) or the mountains (Cascade Range) within a few hours. Consequently, we have 
micro-climates and the weather can vary depending on where you are. I like to hike a lot, so I need 
to know where would be the best place to go for a day trip easily. I plan to use this gem for an app
that will rank specified locations to help me decide where to go on the day of the trip. 

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
`WeatherJudge` takes longitude and latitude as input and then returns an overall weather score, and scores of weather aspect via `WeatherData` class.

Please see [Forecast IO's documentation](https://developer.forecast.io/) for creating an api key. 

To configure you can do:

```ruby
WeatherJudge.configure do |configuration|
  configuration.forecast_io_api_key = `(your api key here)`
  configuration.max_cloud_cover = 0.60  
  configuration.max_percent_rain = 0.30
  configuration.max_wind_speed = 22
  configuration.ideal_temp_range = { min: 50, max: 80}
  configuration.temp_range_delta = 10
end
```

or 

```ruby
WeatherJudge.forecast_io_api_key = `(your api key here)`
WeatherJudge.max_cloud_cover = 0.60
# and so forth
```

More details on configuration
 - `max_cloud_cover`: Maximum cloud cover you are willing to tolerate. A decimal number between 0 to 1
 - `max_percent_rain`: Maximum change of rain you are willing to tolerate. A decimal number between 0 to 1
 - `max_wind_speed`: Maximum wind speed you are willing to tolerate. Default is 15 mph.
 - `ideal_temp_range`: Ideal temperature range in fahrenheit expressed in hash
 - `temp_range_delta`: The delta for slightly less than ideal temperate range in fahrenheit

To run, you need to pass in a valid coordinates.

```ruby
data = WeatherJudge.run(44.123, -122.123)
# => Returns `WeatherData` object

data.total_location_score
# => returns a score of up to 100
```

List of available methods for `WeatherData`
- `raw_data` returns forecast data in `Hashie` (More info on Hashie [here](https://github.com/intridea/hashie)) . Example:
  ```
  => #<Hashie::Mash apparentTemperatureMax=85.83 apparentTemperatureMaxTime=1472702400 apparentTemperatureMin=79.79 apparentTemperatureMinTime=1472734800 cloudCover=0.17 dewPoint=70.42 humidity=0.72 icon="partly-cloudy-night" moonPhase=0.99 ozone=280.5 precipIntensity=0.001 precipIntensityMax=0.0025 precipIntensityMaxTime=1472677200 precipProbability=0.07 precipType="rain" pressure=1009.95 summary="Partly cloudy in the morning." sunriseTime=1472673538 sunsetTime=1472719928 temperatureMax=81.76 temperatureMaxTime=1472702400 temperatureMin=79.79 temperatureMinTime=1472734800 time=1472652000 windBearing=186 windSpeed=4.09>

  ```
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
near future. A few of obvious future plans are:
 - Add ability to specify a date for retrieving scored data
 - Other weather criteria to evaluate

## Contributing
 
Bugs and pull requests are welcome, but if you want to make significant changes, please fork this project 
and make changes there until you are satisfied, and then create a pull request. Please remember to add
tests. :)

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Copyright
Copyright (c) 2016 Makoto Scott-Hinkle. Please see LICENSE.txt for details.