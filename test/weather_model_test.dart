import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';

void main() {
  const testLatitude = 48.8534;
  const testLongitude = 2.3488;
  final testWeather = Weather(
    latitude: testLatitude,
    longitude: testLongitude,
    cityName: 'Paris',
    description: 'clear sky',
    icon: '01',
    temperatureActual: 20,
    temperatureFeelsLike: 19,
    temperatureMin: 15,
    temperatureMax: 22,
    humidity: 55,
    weatherDate: DateTime.fromMillisecondsSinceEpoch(1641052800 * 1000),
    sunrise: DateTime.fromMillisecondsSinceEpoch(1641041400 * 1000),
    sunset: DateTime.fromMillisecondsSinceEpoch(1641078600 * 1000),
  );
  final weatherResponse = http.Response(
    """{
            "coord": {"lat": $testLatitude, "lon": $testLongitude},
            "weather": [
              {"description": "clear sky", "icon": "01d"}
            ],
            "main": {
              "temp": 20,
              "feels_like": 19,
              "temp_min": 15,
              "temp_max": 22,
              "humidity": 55
            },
            "sys": {"sunrise": 1641041400, "sunset": 1641078600},
            "dt": 1641052800,
            "name": "Paris"
          }""",
    200,
  );

  group('Weather model tests', () {
    test('fromJson returns correct weather data for given json response',
        () async {
      final Weather result =
          Weather.fromJson(json.decode(weatherResponse.body));

      expect(result.cityName, equals(testWeather.cityName));
      expect(result.latitude, equals(testWeather.latitude));
      expect(result.longitude, equals(testWeather.longitude));

      expect(result.description, equals(testWeather.description));
      expect(result.icon, equals(testWeather.icon));
      expect(result.temperatureActual, equals(testWeather.temperatureActual));
      expect(result.temperatureFeelsLike,
          equals(testWeather.temperatureFeelsLike));
      expect(result.temperatureMin, equals(testWeather.temperatureMin));

      expect(result.temperatureMax, equals(testWeather.temperatureMax));
      expect(result.humidity, equals(testWeather.humidity));
      expect(result.sunrise, equals(testWeather.sunrise));
      expect(result.sunset, equals(testWeather.sunset));
      expect(result.weatherDate, equals(testWeather.weatherDate));
    });
    test('toJson returns correct weather object for given json response',
        () async {
      final Map<String, dynamic> result = testWeather.toJson();

      expect(result['name'], equals(testWeather.cityName));
      expect(result['coord']['lat'], equals(testWeather.latitude));
      expect(result['coord']['lon'], equals(testWeather.longitude));
      expect(
          result['weather'][0]['description'], equals(testWeather.description));
      expect(result['weather'][0]['icon'], equals(testWeather.icon));
      expect(result['main']['temp'], equals(testWeather.temperatureActual));
      expect(result['main']['feels_like'],
          equals(testWeather.temperatureFeelsLike));
      expect(result['main']['temp_min'], equals(testWeather.temperatureMin));
      expect(result['main']['temp_max'], equals(testWeather.temperatureMax));
      expect(result['main']['humidity'], equals(testWeather.humidity));
      expect(result['dt'],
          equals(testWeather.weatherDate.millisecondsSinceEpoch ~/ 1000));
    });
  });
}
