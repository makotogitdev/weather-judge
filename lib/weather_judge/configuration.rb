module WeatherJudge
  module Configuration
    attr_writer :forecast_io_api_key

    def forecast_io_api_key
      @forecast_io_api_key
    end
  end
end
