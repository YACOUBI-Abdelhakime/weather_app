import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/api_key.dart';
import 'package:weather_app/models/week_weather_model.dart';

class LocationRepository {
  /// Check if city name exists
  Future<({bool isCityExists, WeekWeather? weekWeather})> checkCityNameIfExists(
      {required String cityName}) async {
    WeekWeather weekWeatherData;
    // Send get request to get week weather data
    http.Response response = await http.get(
      Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&units=metric&lang=fr&appid=$API_KEY',
      ),
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
        'Accept': 'application/json',
      },
    );
    // Check status code if 200 then city name exists
    if (response.statusCode == 200) {
      // Convert response to WeekWeather object
      weekWeatherData = WeekWeather.fromJson(json.decode(response.body));
      return (isCityExists: true, weekWeather: weekWeatherData);
    } else {
      return (isCityExists: false, weekWeather: null);
    }
  }
}
