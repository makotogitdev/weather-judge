require "weather_judge/version"
require 'forecast_io'
require 'weather_judge/weather_data'

module WeatherJudge
  class << self
    API_KEY = '418debdbf52e32133ad890c2b4809c21'.freeze

    def run(latitude, longitude)
      ForecastIO.api_key = API_KEY
      forecast = ForecastIO.forecast(latitude, longitude, params: { exclude: 'hourly,minutely,alerts,flags'})
      @forecast_today = forecast.daily.data.first

      WeatherData.new(@forecast_today)
    end
  end
end
