import 'package:localstorage/localstorage.dart';
import 'package:weather_app/models/week_weather_model.dart';

class LocalStorageRepository {
  /// Local storage instance
  final LocalStorage localStorage = LocalStorage("Weather_app_local_storage");

  /// Add week weather data to local storage
  Future<void> addWeekWeatherToLocalStorage(
      {required WeekWeather weekWeather}) async {
    // Wait for local storage to be ready
    await localStorage.ready;
    // Get old weekWeathersList from local storage
    List<WeekWeather> weekWeathersList = localStorage
        .getItem('weekWeathersList')
        ?.map<WeekWeather>((weather) => WeekWeather.fromJson(weather))
        .toList();
    // Add new weekWeather to weekWeathersList
    weekWeathersList.add(weekWeather);
    // Save new version of weekWeathersList to local storage
    localStorage.setItem('weekWeathersList',
        weekWeathersList.map((weekWeather) => weekWeather.toJson()).toList());
  }

  /// Add week weather data to local storage
  WeekWeather? getWeekWeatherOfCityNameFromLocalStorage(
      {required String cityName}) {
    WeekWeather? weekWeather;
    // Get old weekWeathersList from local storage
    List<WeekWeather> weekWeathersList = localStorage
        .getItem('weekWeathersList')
        ?.map<WeekWeather>((weather) => WeekWeather.fromJson(weather))
        .toList();

    // Get weekWeather of cityName from weekWeathersList
    try {
      weekWeather = weekWeathersList.firstWhere(
        (weekWeather) => weekWeather.cityName == cityName,
      );
    } catch (_) {
      // If weekWeather of cityName not found
    }

    return weekWeather;
  }

  /// Add selected city name to selected cities list in local storage
  Future<void> addToSelectedCitiesInLocalStorage(
      {required String cityName}) async {
    // Wait for local storage to be ready
    await localStorage.ready;
    // Get old selected cities from local storage
    Set<String> selectedCitiesList = localStorage
        .getItem('selectedCitiesList')
        ?.map<String>((item) => item as String)
        ?.toSet();
    // Add new cityName to selected cities list
    selectedCitiesList.add(cityName);
    // Sort the list alphabetically
    List<String> newSelectedCitiesList = selectedCitiesList.toList()..sort();
    // Save new version of selected cities list to local storage
    localStorage.setItem('selectedCitiesList', newSelectedCitiesList);
  }

  /// Remove selected city name from selected cities list in local storage
  Future<void> removeFromSelectedCitiesInLocalStorage(
      {required String cityName}) async {
    // Wait for local storage to be ready
    await localStorage.ready;
    // Get selected cities from local storage
    Set<String> selectedCitiesList = localStorage
        .getItem('selectedCitiesList')
        ?.map<String>((item) => item as String)
        ?.toSet();
    // Remove cityName from selected cities list
    selectedCitiesList.remove(cityName);
    // Save new version of selected cities list to local storage
    localStorage.setItem('selectedCitiesList', selectedCitiesList.toList());
  }

  /// Get selected cities from local storage
  Set<String> getSelectedCitiesFromLocalStorage() {
    // Get selected cities from local storage
    Set<String>? selectedCitiesList =
        // localStorage.getItem('selectedCitiesList')?.toSet();
        localStorage
            .getItem('selectedCitiesList')
            ?.map<String>((item) => item as String)
            ?.toSet();
    return selectedCitiesList ?? Set();
  }

  /// Set selected city to local storage
  Future<void> setSelectedCityToLocalStorage({required String cityName}) async {
    // Wait for local storage to be ready
    await localStorage.ready;
    // Set selected city to local storage
    localStorage.setItem('selectedCity', cityName);
  }

  /// Get selected city from local storage
  String? getSelectedCityFromLocalStorage() {
    // Get selected city from local storage
    String? selectedCity = localStorage.getItem('selectedCity');
    return selectedCity;
  }
}
