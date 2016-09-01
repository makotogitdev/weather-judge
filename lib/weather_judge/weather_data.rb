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
      score_from_decimal_data(WeatherJudge.max_cloud_cover, @forecast_today.cloudCover)
    end

    def percent_rain_score
      score_from_decimal_data(WeatherJudge.max_percent_rain, @forecast_today.precipProbability)
    end

    def wind_score
      wind_speed = @forecast_today.windSpeed
      max_wind_speed = WeatherJudge.max_wind_speed.to_f
      if wind_speed < max_wind_speed
        ((max_wind_speed - wind_speed) / max_wind_speed) * SCORE_WEIGHT
      else
        0
      end
    end

    def temperature_score
      high_today = @forecast_today.temperatureMax
      min_ideal_temp = WeatherJudge.ideal_temp_range[:min]
      max_ideal_temp = WeatherJudge.ideal_temp_range[:max]
      delta = WeatherJudge.temp_range_delta

      if high_today > min_ideal_temp && high_today < max_ideal_temp
        SCORE_WEIGHT
      elsif high_today > min_ideal_temp - delta && high_today < min_ideal_temp ||
          high_today > max_ideal_temp && high_today < max_ideal_temp + delta
        SCORE_WEIGHT.to_f / 2
      else
        SCORE_WEIGHT.to_f / 4
      end
    end

    private

    # Calculates weather quality from decimal data, with an assumption that larger the
    # data value the worse. E.g. (80% cloud cover returns smaller score than 50% cloud cover.)
    def score_from_decimal_data(max_allowed, data)
      if !max_allowed.nil?
        if data < max_allowed
          (((max_allowed.to_d - data) / max_allowed) * SCORE_WEIGHT).to_f
        else
          0
        end
      else
        ((1.to_d - data) * SCORE_WEIGHT).to_f
      end
    end
  end
end
