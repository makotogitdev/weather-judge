require 'spec_helper'

describe WeatherJudge::WeatherData do
  DELTA = 0.0001

  describe '#cloud_cover_score' do
    context 'when max cloud cover is not defined' do
      it 'should return correct cloud cover score' do
        forecast = double("Forecast", :cloudCover => 0.80)
        data = WeatherJudge::WeatherData.new(forecast)
        expect(data.cloud_cover_score).to be_within(DELTA).of(5.0)
      end
    end

    context 'when max cloud cover is defined' do
      before do
        WeatherJudge.max_cloud_cover = 0.60
      end

      it 'should return correct cloud cover score based on proximity to max cloud cover' do
        forecast = double("Forecast", :cloudCover => 0.20)
        data = WeatherJudge::WeatherData.new(forecast)
        expect(data.cloud_cover_score).to be_within(DELTA).of(16.6666)
      end

      it 'should return 0 when cloud cover is beyond the maximum' do
        forecast = double("Forecast", :cloudCover => 0.80)
        data = WeatherJudge::WeatherData.new(forecast)
        expect(data.cloud_cover_score).to eq(0)
      end
    end
  end

  describe '#percent_rain_score' do
    context 'when max percent rain is not defined' do
      it 'should return correct percent rain score' do
        forecast = double("Forecast", :precipProbability => 0.80)
        data = WeatherJudge::WeatherData.new(forecast)
        expect(data.percent_rain_score).to be_within(DELTA).of(5.0)
      end
    end

    context 'when max percent rain is defined' do
      before do
        WeatherJudge.max_percent_rain = 0.60
      end

      it 'should return correct percent rain score based on proximity to max percent rain' do
        forecast = double("Forecast", :precipProbability => 0.20)
        data = WeatherJudge::WeatherData.new(forecast)
        expect(data.percent_rain_score).to be_within(DELTA).of(16.6666)
      end

      it 'should return 0 when percen rain is beyond the maximum' do
        forecast = double("Forecast", :precipProbability => 0.80)
        data = WeatherJudge::WeatherData.new(forecast)
        expect(data.percent_rain_score).to eq(0)
      end
    end
  end

  describe '#wind_score' do
    it 'should return the correct wind score based on 0-15 mph wind' do
      forecast = double("Forecast", :windSpeed => 5)
      data = WeatherJudge::WeatherData.new(forecast)
      expect(data.wind_score).to be_within(DELTA).of(16.6666)
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

    it 'should return the correct score when max wind speed is defined' do
      WeatherJudge.max_wind_speed = 25
      forecast = double("Forecast", :windSpeed => 5)
      data = WeatherJudge::WeatherData.new(forecast)
      expect(data.wind_score).to be_within(DELTA).of(20.0)
    end
  end

  describe '#temperature_score' do
    context 'when ideal temperature range is not defined' do
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

    context 'when ideal temperature range is defined' do
      before do
        WeatherJudge.ideal_temp_range = { min: 65, max: 75 }
        WeatherJudge.temp_range_delta = 15
      end

      it 'should return full score when temperature is between 65 and 75' do
        forecast = double("Forecast", :temperatureMax => 70)
        data = WeatherJudge::WeatherData.new(forecast)
        expect(data.temperature_score).to eq(25)
      end

      it 'should return half of score weight when temp is 50-65 or 75-90' do
        forecast = double("Forecast", :temperatureMax => 60)
        data = WeatherJudge::WeatherData.new(forecast)
        expect(data.temperature_score).to eq(12.5)

        forecast = double("Forecast", :temperatureMax => 80)
        data = WeatherJudge::WeatherData.new(forecast)
        expect(data.temperature_score).to eq(12.5)
      end

      it 'should return quarter of score weight when temp is outside of 50-90' do
        forecast = double("Forecast", :temperatureMax => 40)
        data = WeatherJudge::WeatherData.new(forecast)
        expect(data.temperature_score).to eq(6.25)
      end
    end
  end
end
