require 'spec_helper'

describe WeatherJudge::WeatherData do
  describe '#cloud_cover_score' do
    it 'should return cloud cover score multiplied by score weight' do
      forecast = double("Forecast", :cloudCover => 0.80)
      data = WeatherJudge::WeatherData.new(forecast)
      expect(data.cloud_cover_score).to eq(20)
    end
  end

  describe '#percent_rain_score' do
    it 'should return percent rain score multiplied by score weight' do
      forecast = double("Forecast", :precipProbability => 0.80)
      data = WeatherJudge::WeatherData.new(forecast)
      expect(data.percent_rain_score).to eq(20)
    end
  end

  describe '#wind_score' do
    it 'should return correct wind score based on 0-15 mph wind' do
      forecast = double("Forecast", :windSpeed => 5)
      data = WeatherJudge::WeatherData.new(forecast)
      expect(data.wind_score).to be_within(0.01).of(16.666)
    end

    it 'should return full score when wind speed is 0' do
      forecast = double("Forecast", :windSpeed => 0)
      data = WeatherJudge::WeatherData.new(forecast)
      expect(data.wind_score).to eq(25)
    end

    it 'should return 0 score when wind speed is greater than 15' do
      forecast = double("Forecast", :windSpeed => 20)
      data = WeatherJudge::WeatherData.new(forecast)
      expect(data.wind_score).to eq(0)
    end
  end

  describe '#temperature_score' do
    it 'should return full score when temperature is between 67 and 77' do
      forecast = double("Forecast", :temperatureMax => 70)
      data = WeatherJudge::WeatherData.new(forecast)
      expect(data.temperature_score).to eq(25)
    end

    it 'should return half of score weight when temp is 55-67 or 77-85' do
      forecast = double("Forecast", :temperatureMax => 60)
      data = WeatherJudge::WeatherData.new(forecast)
      expect(data.temperature_score).to eq(12.5)

      forecast = double("Forecast", :temperatureMax => 80)
      data = WeatherJudge::WeatherData.new(forecast)
      expect(data.temperature_score).to eq(12.5)
    end

    it 'should return quarter of score weight when temp is outside of 55-85' do
      forecast = double("Forecast", :temperatureMax => 40)
      data = WeatherJudge::WeatherData.new(forecast)
      expect(data.temperature_score).to eq(6.25)
    end
  end
end
