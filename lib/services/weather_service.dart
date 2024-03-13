import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/models/week_weather_model.dart';
import 'package:weather_app/repositories/weather_repository.dart';

class WeatherService {
  final WeatherRepository weatherRepository = WeatherRepository();

  /// Get actual weather data
  Future<Weather> getActualWeatherData() async {
    // Get actual weather data from api
    Weather weatherData = await weatherRepository.getActualWeatherDataFromApi();
    return weatherData;
  }

  Future<WeekWeather> getWeekWeatherData() async {
    // Get actual weather data from api
    WeekWeather weekWeatherData =
        await weatherRepository.getWeekWeatherDataFromApi();
    return weekWeatherData;
  }
}