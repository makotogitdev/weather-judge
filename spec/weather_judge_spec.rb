require 'spec_helper'

describe WeatherJudge do
  describe '.run' do
    before do
      todays_forecast = double("TodaysForecast")
      daily_forecast_data = double("DailyForecastData", :first => todays_forecast)
      daily_forecast = double("DailyForecast", :data => daily_forecast_data)
      forecast_data = double("Forecast", :daily => daily_forecast)

      allow(ForecastIO).to receive(:forecast).and_return(forecast_data)
    end

    it 'calls to get forecast' do
      WeatherJudge.run(44, -125)
      expect(ForecastIO).to have_received(:forecast).once
    end

    it 'returns WeatherData' do
      expect(WeatherJudge.run(44, -125)).to be_instance_of(WeatherJudge::WeatherData)
    end
  end
end
