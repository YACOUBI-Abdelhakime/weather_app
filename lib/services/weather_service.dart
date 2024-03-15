import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/models/week_weather_model.dart';
import 'package:weather_app/repositories/weather_repository.dart';

class WeatherService {
  final WeatherRepository weatherRepository = WeatherRepository();

  /// Get actual weather data service
  Future<Weather?> getActualWeatherData({
    required double? latitude,
    required double? longitude,
    required String? cityName,
  }) async {
    Weather? weatherData;
    if (latitude != null && longitude != null) {
      // Get actual weather data using coordinates
      weatherData =
          await weatherRepository.getActualWeatherByCoordinatesDataFromApi(
              latitude: latitude, longitude: longitude);
    } else if (cityName != null) {
      // Get actual weather data using city name
      weatherData = await weatherRepository
          .getActualWeatherDataByCityNameFromApi(cityName: cityName);
    }
    return weatherData;
  }

  /// Get week weather data service
  Future<WeekWeather?> getWeekWeatherData({
    required double? latitude,
    required double? longitude,
    required String? cityName,
  }) async {
    WeekWeather? weekWeatherData;
    if (latitude != null && longitude != null) {
      // Get week weather data using coordinates
      weekWeatherData =
          await weatherRepository.getWeekWeatherDataByCoordinatesFromApi(
              latitude: latitude, longitude: longitude);
    } else if (cityName != null) {
      // Get week weather data using city name
      weekWeatherData = await weatherRepository
          .getWeekWeatherDataByCityNameFromApi(cityName: cityName);
    }
    return weekWeatherData;
  }
}
