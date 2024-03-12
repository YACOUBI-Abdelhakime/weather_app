import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/api_key.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherRepository {
  /// Get actual weather data from api
  Future<Weather> getActualWeatherDataFromApi() async {
    Weather weatherData;
    // Send request to api to get actual weather data
    http.Response response = await http.get(
      Uri.parse(
          'http://api.openweathermap.org/data/2.5/weather?q=Paris&units=metric&lang=fr&appid=$API_KEY'),
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
        'Accept': 'application/json',
      },
    );
    // Convert response to Weather object
    weatherData = Weather.fromJson(json.decode(response.body));
    return weatherData;
  }
}
