import 'dart:io';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/models/week_weather_model.dart';
import 'package:weather_app/repositories/weather_repository.dart';
import 'package:weather_app/services/local_storage_service.dart';

class WeatherService {
  final WeatherRepository weatherRepository = WeatherRepository();
  final LocalStorageService localStorageService = LocalStorageService();

  /// Get actual weather data service
  Future<Weather?> getActualWeatherData({
    required double? latitude,
    required double? longitude,
    required String? cityName,
  }) async {
    Weather? weatherData;
    try {
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
    } on SocketException catch (_) {
      // In case of no internet connection
      WeekWeather? weekWeatherData;
      if (cityName != null) {
        // Get week weather data from local storage
        weekWeatherData = await localStorageService.getWeekWeatherOfCityName(
            cityName: cityName);
      }
      if (weekWeatherData != null) {
        // Get actual weather data from week weathers data
        // Find the weather of this time of today
        weatherData = weekWeatherData.weathers.firstWhere(
          (Weather weather) {
            int differenceInMinutes =
                weather.weatherDate.difference(DateTime.now()).inMinutes.abs();
            // 1 hour and 30 minutes of difference
            return differenceInMinutes <= 90;
          },
        );

        // Set city name, latitude, longitude, sunrise and sunset
        // because weather in the weekWeather does not contain these data
        weatherData.cityName = cityName;
        weatherData.latitude = weekWeatherData.latitude;
        weatherData.longitude = weekWeatherData.longitude;
        weatherData.sunrise = weekWeatherData.sunrise;
        weatherData.sunset = weekWeatherData.sunset;
      }
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
    try {
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
    } on SocketException catch (_) {
      // In case of no internet connection
      if (cityName != null) {
        // Get week weather data from local storage
        weekWeatherData = await localStorageService.getWeekWeatherOfCityName(
            cityName: cityName);
      }
    }
    // Add week weather data to local storage
    if (weekWeatherData != null) {
      await localStorageService.saveWeekWeather(
        weekWeather: weekWeatherData,
      );
    }
    return weekWeatherData;
  }
}
