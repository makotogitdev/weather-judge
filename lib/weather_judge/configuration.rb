module WeatherJudge
  module Configuration
    attr_writer :forecast_io_api_key, :max_cloud_cover, :max_percent_rain

    # For configuring WeatherJudge with block style
    def configure
      yield self
    end

    def forecast_io_api_key
      @forecast_io_api_key
    end

    def max_cloud_cover
      @max_cloud_cover
    end

    def max_percent_rain
      @max_percent_rain
    end
  end
end
