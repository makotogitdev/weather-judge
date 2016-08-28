require "weather_judge/version"
require 'forecast_io'

module WeatherJudge
  class << self
    SCORE_WEIGHT = 25
    API_KEY = '418debdbf52e32133ad890c2b4809c21'.freeze

    def run(latitude, longitude)
      ForecastIO.api_key = API_KEY
      forecast = ForecastIO.forecast(latitude, longitude, params: { exclude: 'hourly,minutely,alerts,flags'})
      @forecast_today = forecast.daily.data.first

      total_location_score
    end

    def raw_data
      @forecast_today
    end

    private

    def total_location_score
      cloud_cover_score + percent_rain_score + wind_score + temperature_score
    end

    def cloud_cover_score
      @forecast_today.cloudCover * SCORE_WEIGHT
    end

    def percent_rain_score
      @forecast_today.precipProbability * SCORE_WEIGHT
    end

    def wind_score
      wind_speed = @forecast_today.windSpeed
      max_wind_speed = 15
      if wind_speed == 0
        SCORE_WEIGHT
      elsif wind_speed < max_wind_speed
        ((max_wind_speed - wind_speed) / max_wind_speed) * SCORE_WEIGHT
      else
        0
      end
    end

    def temperature_score
      max_temperature = @forecast_today.temperatureMax

      if max_temperature > 67 && max_temperature < 77
        SCORE_WEIGHT
      elsif max_temperature > 55 && max_temperature < 67 || max_temperature > 77 && max_temperature < 85
        SCORE_WEIGHT.to_f / 2
      else
        SCORE_WEIGHT.to_f / 4
      end
    end
  end
end
