import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/api_key.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/models/week_weather_model.dart';

class WeatherRepository {
  /// Get actual weather data from api
  Future<Weather> getActualWeatherDataFromApi() async {
    Weather weatherData;
    // Send get request to get actual weather data
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

  Future<WeekWeather> getWeekWeatherDataFromApi() async {
    WeekWeather weekWeatherData;
    // Send get request to get week weather data
    http.Response response = await http.get(
      Uri.parse(
          'http://api.openweathermap.org/data/2.5/forecast?q=Paris&units=metric&lang=fr&appid=$API_KEY'),
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
        'Accept': 'application/json',
      },
    ); 
    // Convert response to WeekWeather object
    weekWeatherData = WeekWeather.fromJson(json.decode(response.body)); 
    return weekWeatherData;
  }
}
