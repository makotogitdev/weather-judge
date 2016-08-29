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

    subject { WeatherJudge.run(44, -125) }

    it 'calls to get forecast' do
      subject
      expect(ForecastIO).to have_received(:forecast).once
    end

    it 'returns WeatherData' do
      expect(subject).to be_instance_of(WeatherJudge::WeatherData)
    end
  end
end
