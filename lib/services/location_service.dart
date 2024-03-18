import 'package:geolocator/geolocator.dart';
import 'package:weather_app/models/week_weather_model.dart';
import 'package:weather_app/repositories/location_repository.dart';
import 'package:weather_app/services/local_storage_service.dart';
import 'package:weather_app/shared/helpers.dart';

class LocationService {
  final LocationRepository locationRepository = LocationRepository();
  final LocalStorageService localStorageService = LocalStorageService();

  /// Get actual weather data
  Future<(double, double)> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return (position.latitude, position.longitude);
  }

  /// Check if city name exists service
  Future<bool> checkCityNameIfExists({
    required String cityName,
  }) async {
    bool isCityExists;
    WeekWeather? weekWeather;
    // Check if city name exists
    (isCityExists: isCityExists, weekWeather: weekWeather) =
        await locationRepository.checkCityNameIfExists(cityName: cityName);
    if (isCityExists) {
      // Add selected city to local storage
      localStorageService.addToSelectedCities(
        cityName: Helpers().capitalize(cityName),
      );
      // Add selected city week weather to local storage
      if (weekWeather != null) {
        localStorageService.saveWeekWeather(
          weekWeather: weekWeather,
        );
      }
    }

    return isCityExists;
  }
}
