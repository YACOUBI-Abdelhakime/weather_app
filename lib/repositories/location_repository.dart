import 'package:http/http.dart' as http;
import 'package:weather_app/api_key.dart';

class LocationRepository {
  /// Check if city name exists
  Future<bool> checkCityNameIfExists({required String cityName}) async {
    // Send get request to get week weather data
    http.Response response = await http.get(
      Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$API_KEY',
      ),
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
        'Accept': 'application/json',
      },
    );
    // Check status code if 200 then city name exists
    return response.statusCode == 200;
  }
}
