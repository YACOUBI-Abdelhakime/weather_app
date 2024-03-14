import 'package:geolocator/geolocator.dart';

class LocationService {
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
}
