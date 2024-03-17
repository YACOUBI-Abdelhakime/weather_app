import 'package:weather_app/models/week_weather_model.dart';
import 'package:weather_app/repositories/local_storage_repository.dart';

class LocalStorageService {
  final LocalStorageRepository localStorageRepository =
      LocalStorageRepository();

  /// Add week weather data
  Future<void> addWeekWeather({required WeekWeather weekWeather}) async {
    // Add week weather data to local storage
    await localStorageRepository.addWeekWeatherToLocalStorage(
        weekWeather: weekWeather);
  }

  /// Get week weather data of city name
  WeekWeather? getWeekWeatherOfCityName({required String cityName}) {
    // Get week weather data of city name from local storage
    return localStorageRepository.getWeekWeatherOfCityNameFromLocalStorage(
      cityName: cityName,
    );
  }

  /// Add selected city name to selected cities list
  Future<void> addToSelectedCities({required String cityName}) async {
    // Add new cityName to selected cities list
    await localStorageRepository.addToSelectedCitiesInLocalStorage(
      cityName: cityName,
    );
  }

  /// Remove selected city name from selected cities list
  Future<void> removeSelectedCityName({required String cityName}) async {
    // Remove cityName from selected cities list
    await localStorageRepository.removeFromSelectedCitiesInLocalStorage(
      cityName: cityName,
    );
  }

  /// Get selected cities list
  Set<String> getSelectedCities() {
    // Get selected cities list from local storage
    return localStorageRepository.getSelectedCitiesFromLocalStorage();
  }

  /// Set selected city
  Future<void> setSelectedCity({required String cityName}) async {
    // Set selected city to local storage
    await localStorageRepository.setSelectedCityToLocalStorage(
      cityName: cityName,
    );
  }

  /// Get selected city
  String? getSelectedCity() {
    // Get selected city from local storage
    return localStorageRepository.getSelectedCityFromLocalStorage();
  }
}
