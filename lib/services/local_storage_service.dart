import 'package:weather_app/models/week_weather_model.dart';
import 'package:weather_app/repositories/local_storage_repository.dart';

class LocalStorageService {
  final LocalStorageRepository localStorageRepository;

  LocalStorageService({
    required this.localStorageRepository,
  });

  /// Add week weather data
  Future<void> saveWeekWeather({required WeekWeather weekWeather}) async {
    // Add week weather data to local storage
    await localStorageRepository.addWeekWeatherToLocalStorage(
        weekWeather: weekWeather);
  }

  /// Get week weather data of city name
  Future<WeekWeather?> getWeekWeatherOfCityName(
      {required String cityName}) async {
    // Get week weather data of city name from local storage
    return await localStorageRepository
        .getWeekWeatherOfCityNameFromLocalStorage(
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
  Future<Set<String>> getSelectedCities() async {
    // Get selected cities list from local storage
    return await localStorageRepository.getSelectedCitiesFromLocalStorage();
  }

  /// Set selected city
  Future<void> setSelectedCity({required String cityName}) async {
    // Set selected city to local storage
    await localStorageRepository.setSelectedCityToLocalStorage(
      cityName: cityName,
    );
  }

  /// Get selected city
  Future<String?> getSelectedCity() async {
    // Get selected city from local storage
    return await localStorageRepository.getSelectedCityFromLocalStorage();
  }
}
