module WeatherJudge
  module Configuration
    attr_writer :forecast_io_api_key, :max_cloud_cover, :max_percent_rain, :max_wind_speed

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

    # Maximum wind speed you are willing to tolerate
    def max_wind_speed
      @max_wind_speed || 15
    end
  end
end
