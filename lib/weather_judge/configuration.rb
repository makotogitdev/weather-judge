module WeatherJudge
  module Configuration
    attr_writer :forecast_io_api_key, :max_cloud_cover, :max_percent_rain, :max_wind_speed,
                :ideal_temp_range, :temp_range_delta

    # For configuring WeatherJudge with block style
    def configure
      yield self
    end

    def forecast_io_api_key
      @forecast_io_api_key
    end

    # Maximum cloud cover you are willing to tolerate
    def max_cloud_cover
      @max_cloud_cover
    end

    # Maximum change of rain you are willing to tolerate
    def max_percent_rain
      @max_percent_rain
    end

    # Maximum wind speed you are willing to tolerate. Default is 15mph.
    def max_wind_speed
      @max_wind_speed || 15
    end

    # Ideal temperature range in fahrenheit expressed in hash
    def ideal_temp_range
      @ideal_temp_range || { min: 67, max: 77 }
    end

    # The delta for slightly less than ideal temperate range in fahrenheit
    def temp_range_delta
      @temp_range_delta || 10
    end
  end
end
