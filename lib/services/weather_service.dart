import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/models/week_weather_model.dart';
import 'package:weather_app/repositories/weather_repository.dart';

class WeatherService {
  final WeatherRepository weatherRepository = WeatherRepository();

  /// Get actual weather data
  Future<Weather> getActualWeatherData(
      {required double latitude, required double longitude}) async {
    // Get actual weather data from api
    Weather weatherData = await weatherRepository.getActualWeatherDataFromApi(
        latitude: latitude, longitude: longitude);
    return weatherData;
  }

  Future<WeekWeather> getWeekWeatherData(
      {required double latitude, required double longitude}) async {
    // Get actual weather data from api
    WeekWeather weekWeatherData = await weatherRepository
        .getWeekWeatherDataFromApi(latitude: latitude, longitude: longitude);
    return weekWeatherData;
  }
}
