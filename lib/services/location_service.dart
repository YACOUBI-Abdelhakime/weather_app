import 'package:geolocator/geolocator.dart';
import 'package:weather_app/repositories/location_repository.dart';

class LocationService {
  final LocationRepository locationRepository = LocationRepository();

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
    // Check if city name exists
    isCityExists =
        await locationRepository.checkCityNameIfExists(cityName: cityName);

    return isCityExists;
  }
}
