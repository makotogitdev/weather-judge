require "weather_judge/version"
require 'forecast_io'
require 'weather_judge/weather_data'
require 'weather_judge/configuration'

module WeatherJudge
  extend Configuration

  class << self

    # Retrieves WeatherData object for today's forecast given latitude and longitude.
    def run(latitude, longitude)
      validate_coordinates(latitude, longitude)

      ForecastIO.api_key = WeatherJudge.forecast_io_api_key
      forecast = ForecastIO.forecast(latitude, longitude, params: { exclude: 'hourly,minutely,alerts,flags'})

      if forecast.nil?
        raise StandardError.new("Unable to obtain forecast! Check your network connectivity and API key")
      end

      @forecast_today = forecast.daily.data.first

      WeatherData.new(@forecast_today)
    end

    private

    def validate_coordinates(latitude, longitude)
      unless latitude >= -90 && latitude <= 90 && longitude >= -180 && longitude <= 180
        raise ArgumentError.new("Invalid coordinates!")
      end
    end
  end
end
