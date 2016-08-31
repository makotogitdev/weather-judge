require 'bigdecimal'
require 'bigdecimal/util'

# Calculates score for 4 different weather aspects: sky cover,
# chance of rain, wind, and temperature

module WeatherJudge
  class WeatherData
    SCORE_WEIGHT = 25

    def initialize(forecast_today)
      @forecast_today = forecast_today
    end

    # Returns raw forecast data object
    def raw_data
      @forecast_today
    end

    # Returns total location score based on forecast. It is the sum of
    # cloud cover score, percent rain score, wind score, and temperature score.
    def total_location_score
      cloud_cover_score + percent_rain_score + wind_score + temperature_score
    end

    def cloud_cover_score
      if !WeatherJudge.max_cloud_cover.nil?
        if @forecast_today.cloudCover < WeatherJudge.max_cloud_cover
          ((WeatherJudge.max_cloud_cover - @forecast_today.cloudCover) / WeatherJudge.max_cloud_cover) * SCORE_WEIGHT
        else
          0
        end
      else
        ((1.to_d - @forecast_today.cloudCover) * SCORE_WEIGHT).to_f
      end
    end

    def percent_rain_score
      @forecast_today.precipProbability * SCORE_WEIGHT
    end

    def wind_score
      wind_speed = @forecast_today.windSpeed
      max_wind_speed = 15.to_f
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
