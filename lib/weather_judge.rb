require "weather_judge/version"
require 'forecast_io'
require 'weather_judge/weather_data'
require 'weather_judge/configuration'

module WeatherJudge
  extend Configuration

  class << self

    # Retrieves WeatherData object for today's forecast given latitude and longitude.
    def run(latitude, longitude)
      ForecastIO.api_key = WeatherJudge.forecast_io_api_key
      forecast = ForecastIO.forecast(latitude, longitude, params: { exclude: 'hourly,minutely,alerts,flags'})
      @forecast_today = forecast.daily.data.first

      WeatherData.new(@forecast_today)
    end
  end
end
