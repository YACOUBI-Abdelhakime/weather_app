import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/api_key.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/models/week_weather_model.dart';

class WeatherRepository {
  final http.Client client;
  WeatherRepository({required this.client});

  /// Get actual weather data using coordinates from api
  Future<Weather> getActualWeatherByCoordinatesDataFromApi(
      {required double latitude, required double longitude}) async {
    Weather weatherData;
    // Send get request to get actual weather data
    http.Response response = await client.get(
      Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&units=metric&lang=fr&appid=$API_KEY',
      ),
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
        'Accept': 'application/json',
      },
    );
    // Convert response to Weather object
    weatherData = Weather.fromJson(json.decode(response.body));
    return weatherData;
  }

  /// Get actual weather data using city name from api
  Future<Weather> getActualWeatherDataByCityNameFromApi(
      {required String cityName}) async {
    Weather weatherData;
    // Send get request to get actual weather data
    http.Response response = await client.get(
      Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&units=metric&lang=fr&appid=$API_KEY',
      ),
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
        'Accept': 'application/json',
      },
    );
    // Convert response to Weather object
    weatherData = Weather.fromJson(json.decode(response.body));
    return weatherData;
  }

  /// Get week weather data using coordinates from api
  Future<WeekWeather> getWeekWeatherDataByCoordinatesFromApi(
      {required double latitude, required double longitude}) async {
    WeekWeather weekWeatherData;
    // Send get request to get week weather data
    http.Response response = await client.get(
      Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&units=metric&lang=fr&appid=$API_KEY',
      ),
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
        'Accept': 'application/json',
      },
    );
    // Convert response to WeekWeather object
    weekWeatherData = WeekWeather.fromJson(json.decode(response.body));
    return weekWeatherData;
  }

  /// Get week weather data using city name from api
  Future<WeekWeather> getWeekWeatherDataByCityNameFromApi(
      {required String cityName}) async {
    WeekWeather weekWeatherData;
    // Send get request to get week weather data
    http.Response response = await client.get(
      Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&units=metric&lang=fr&appid=$API_KEY',
      ),
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
