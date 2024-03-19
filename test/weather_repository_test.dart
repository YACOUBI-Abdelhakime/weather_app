import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/api_key.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/models/week_weather_model.dart';
import 'package:weather_app/repositories/weather_repository.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late MockClient mockClient;
  late WeatherRepository weatherRepository;

  const latitude = 48.8534;
  const longitude = 2.3486;
  const cityName = "Paris";
  final expectedWeatherData = Weather(
    latitude: latitude,
    longitude: longitude,
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
            "coord": {"lat": $latitude, "lon": $longitude},
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
  final weekWeatherResponse = http.Response(
    """{
            "city": {
              "coord": {
                "lon": 2.3488, 
                "lat": 48.8534
              },
              "sunrise": 1710827700,
              "sunset": 1710871293,
              "name": "Paris"
            },
            "list": [
              {
                "dt": 1641052800,
                "weather": [{"description": "clear sky", "icon": "01d"}],
                "main": {
                  "temp": 20,
                  "feels_like": 19,
                  "temp_min": 15,
                  "temp_max": 22,
                  "humidity": 55
                }
              },
              {
                "dt": 1641052800,
                "weather": [{"description": "few clouds", "icon": "03d"}],
                "main": {
                  "temp": 25,
                  "feels_like": 24,
                  "temp_min": 20,
                  "temp_max": 27,
                  "humidity": 90
                }
              }
            ]
          }""",
    200,
  );
  final expectedWeekWeatherData = WeekWeather(
    latitude: 48.8534,
    longitude: 2.3488,
    cityName: 'Paris',
    sunrise: DateTime.fromMillisecondsSinceEpoch(1710827700 * 1000),
    sunset: DateTime.fromMillisecondsSinceEpoch(1710871293 * 1000),
    weathers: [
      Weather(
        latitude: null,
        longitude: null,
        cityName: null,
        description: 'clear sky',
        icon: '01',
        temperatureActual: 20,
        temperatureFeelsLike: 19,
        temperatureMin: 15,
        temperatureMax: 22,
        humidity: 55,
        weatherDate: DateTime.fromMillisecondsSinceEpoch(1641052800 * 1000),
        sunrise: null,
        sunset: null,
      ),
      Weather(
        latitude: null,
        longitude: null,
        cityName: null,
        description: 'few clouds',
        icon: '03',
        temperatureActual: 25,
        temperatureFeelsLike: 24,
        temperatureMin: 20,
        temperatureMax: 27,
        humidity: 90,
        weatherDate: DateTime.fromMillisecondsSinceEpoch(1641052800 * 1000),
        sunrise: null,
        sunset: null,
      ),
    ],
  );

  setUp(() {
    mockClient = MockClient();
    weatherRepository = WeatherRepository(client: mockClient);
  });

  group('GetActualWeather tests', () {
    test(
      'getActualWeatherByCoordinatesDataFromApi returns Weather object using coordinates',
      () async {
        when(() => mockClient.get(
              Uri.parse(
                'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&units=metric&lang=fr&appid=$API_KEY',
              ),
              headers: {
                "Content-Type": "application/json; charset=UTF-8",
                'Accept': 'application/json',
              },
            )).thenAnswer((_) async => weatherResponse);

        final result =
            await weatherRepository.getActualWeatherByCoordinatesDataFromApi(
          latitude: latitude,
          longitude: longitude,
        );

        expect(result.cityName, equals(expectedWeatherData.cityName));
        expect(result.latitude, equals(expectedWeatherData.latitude));
        expect(result.longitude, equals(expectedWeatherData.longitude));
        expect(result.description, equals(expectedWeatherData.description));
        expect(result.icon, equals(expectedWeatherData.icon));
        expect(result.temperatureActual,
            equals(expectedWeatherData.temperatureActual));
        expect(result.temperatureFeelsLike,
            equals(expectedWeatherData.temperatureFeelsLike));
        expect(
            result.temperatureMin, equals(expectedWeatherData.temperatureMin));
        expect(
            result.temperatureMax, equals(expectedWeatherData.temperatureMax));
        expect(result.humidity, equals(expectedWeatherData.humidity));
        expect(result.weatherDate, equals(expectedWeatherData.weatherDate));
        expect(result.sunrise, equals(expectedWeatherData.sunrise));
        expect(result.sunset, equals(expectedWeatherData.sunset));
      },
    );
    test(
      'getActualWeatherDataByCityNameFromApi returns Weather object using city name',
      () async {
        when(() => mockClient.get(
              Uri.parse(
                'https://api.openweathermap.org/data/2.5/weather?q=$cityName&units=metric&lang=fr&appid=$API_KEY',
              ),
              headers: {
                "Content-Type": "application/json; charset=UTF-8",
                'Accept': 'application/json',
              },
            )).thenAnswer((_) async => weatherResponse);

        final result =
            await weatherRepository.getActualWeatherDataByCityNameFromApi(
          cityName: cityName,
        );

        expect(result.cityName, equals(expectedWeatherData.cityName));
        expect(result.latitude, equals(expectedWeatherData.latitude));
        expect(result.longitude, equals(expectedWeatherData.longitude));
        expect(result.description, equals(expectedWeatherData.description));
        expect(result.icon, equals(expectedWeatherData.icon));
        expect(result.temperatureActual,
            equals(expectedWeatherData.temperatureActual));
        expect(result.temperatureFeelsLike,
            equals(expectedWeatherData.temperatureFeelsLike));
        expect(
            result.temperatureMin, equals(expectedWeatherData.temperatureMin));
        expect(
            result.temperatureMax, equals(expectedWeatherData.temperatureMax));
        expect(result.humidity, equals(expectedWeatherData.humidity));
        expect(result.weatherDate, equals(expectedWeatherData.weatherDate));
        expect(result.sunrise, equals(expectedWeatherData.sunrise));
        expect(result.sunset, equals(expectedWeatherData.sunset));
      },
    );
  });

  group('GetWeekWeather tests', () {
    test(
      'getWeekWeatherDataByCoordinatesFromApi returns Weather object using coordinates',
      () async {
        when(() => mockClient.get(
              Uri.parse(
                'https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&units=metric&lang=fr&appid=$API_KEY',
              ),
              headers: {
                "Content-Type": "application/json; charset=UTF-8",
                'Accept': 'application/json',
              },
            )).thenAnswer((_) async => weekWeatherResponse);

        final result =
            await weatherRepository.getWeekWeatherDataByCoordinatesFromApi(
          latitude: latitude,
          longitude: longitude,
        );

        expect(result.cityName, equals(expectedWeekWeatherData.cityName));
        expect(result.latitude, equals(expectedWeekWeatherData.latitude));
        expect(result.longitude, equals(expectedWeekWeatherData.longitude));
        expect(result.sunrise, equals(expectedWeekWeatherData.sunrise));
        expect(result.sunset, equals(expectedWeekWeatherData.sunset));
        expect(result.weathers.length,
            equals(expectedWeekWeatherData.weathers.length));
        expect(result.weathers[0].cityName,
            equals(expectedWeekWeatherData.weathers[0].cityName));
        expect(result.weathers[0].latitude,
            equals(expectedWeekWeatherData.weathers[0].latitude));
        expect(result.weathers[0].longitude,
            equals(expectedWeekWeatherData.weathers[0].longitude));
        expect(result.weathers[0].description,
            equals(expectedWeekWeatherData.weathers[0].description));
        expect(result.weathers[0].icon,
            equals(expectedWeekWeatherData.weathers[0].icon));
        expect(result.weathers[0].temperatureActual,
            equals(expectedWeekWeatherData.weathers[0].temperatureActual));
        expect(result.weathers[0].temperatureFeelsLike,
            equals(expectedWeekWeatherData.weathers[0].temperatureFeelsLike));
        expect(result.weathers[0].temperatureMin,
            equals(expectedWeekWeatherData.weathers[0].temperatureMin));
        expect(result.weathers[0].temperatureMax,
            equals(expectedWeekWeatherData.weathers[0].temperatureMax));
        expect(result.weathers[0].humidity,
            equals(expectedWeekWeatherData.weathers[0].humidity));
        expect(result.weathers[0].weatherDate,
            equals(expectedWeekWeatherData.weathers[0].weatherDate));
        expect(result.weathers[0].sunrise,
            equals(expectedWeekWeatherData.weathers[0].sunrise));
        expect(result.weathers[0].sunset,
            equals(expectedWeekWeatherData.weathers[0].sunset));
        expect(result.weathers[1].cityName,
            equals(expectedWeekWeatherData.weathers[1].cityName));
        expect(result.weathers[1].latitude,
            equals(expectedWeekWeatherData.weathers[1].latitude));
        expect(result.weathers[1].longitude,
            equals(expectedWeekWeatherData.weathers[1].longitude));
        expect(result.weathers[1].description,
            equals(expectedWeekWeatherData.weathers[1].description));
        expect(result.weathers[1].icon,
            equals(expectedWeekWeatherData.weathers[1].icon));
        expect(result.weathers[1].temperatureActual,
            equals(expectedWeekWeatherData.weathers[1].temperatureActual));
        expect(result.weathers[1].temperatureFeelsLike,
            equals(expectedWeekWeatherData.weathers[1].temperatureFeelsLike));
        expect(result.weathers[1].temperatureMin,
            equals(expectedWeekWeatherData.weathers[1].temperatureMin));
        expect(result.weathers[1].temperatureMax,
            equals(expectedWeekWeatherData.weathers[1].temperatureMax));
        expect(result.weathers[1].humidity,
            equals(expectedWeekWeatherData.weathers[1].humidity));
        expect(result.weathers[1].weatherDate,
            equals(expectedWeekWeatherData.weathers[1].weatherDate));
        expect(result.weathers[1].sunrise,
            equals(expectedWeekWeatherData.weathers[1].sunrise));
        expect(result.weathers[1].sunset,
            equals(expectedWeekWeatherData.weathers[1].sunset));
      },
    );
    test(
      'getWeekWeatherDataByCityNameFromApi returns Weather object using city name',
      () async {
        when(() => mockClient.get(
              Uri.parse(
                'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&units=metric&lang=fr&appid=$API_KEY',
              ),
              headers: {
                "Content-Type": "application/json; charset=UTF-8",
                'Accept': 'application/json',
              },
            )).thenAnswer((_) async => weekWeatherResponse);

        final result =
            await weatherRepository.getWeekWeatherDataByCityNameFromApi(
          cityName: cityName,
        );

        expect(result.cityName, equals(expectedWeekWeatherData.cityName));
        expect(result.latitude, equals(expectedWeekWeatherData.latitude));
        expect(result.longitude, equals(expectedWeekWeatherData.longitude));
        expect(result.sunrise, equals(expectedWeekWeatherData.sunrise));
        expect(result.sunset, equals(expectedWeekWeatherData.sunset));
        expect(result.weathers.length,
            equals(expectedWeekWeatherData.weathers.length));
        expect(result.weathers[0].cityName,
            equals(expectedWeekWeatherData.weathers[0].cityName));
        expect(result.weathers[0].latitude,
            equals(expectedWeekWeatherData.weathers[0].latitude));
        expect(result.weathers[0].longitude,
            equals(expectedWeekWeatherData.weathers[0].longitude));
        expect(result.weathers[0].description,
            equals(expectedWeekWeatherData.weathers[0].description));
        expect(result.weathers[0].icon,
            equals(expectedWeekWeatherData.weathers[0].icon));
        expect(result.weathers[0].temperatureActual,
            equals(expectedWeekWeatherData.weathers[0].temperatureActual));
        expect(result.weathers[0].temperatureFeelsLike,
            equals(expectedWeekWeatherData.weathers[0].temperatureFeelsLike));
        expect(result.weathers[0].temperatureMin,
            equals(expectedWeekWeatherData.weathers[0].temperatureMin));
        expect(result.weathers[0].temperatureMax,
            equals(expectedWeekWeatherData.weathers[0].temperatureMax));
        expect(result.weathers[0].humidity,
            equals(expectedWeekWeatherData.weathers[0].humidity));
        expect(result.weathers[0].weatherDate,
            equals(expectedWeekWeatherData.weathers[0].weatherDate));
        expect(result.weathers[0].sunrise,
            equals(expectedWeekWeatherData.weathers[0].sunrise));
        expect(result.weathers[0].sunset,
            equals(expectedWeekWeatherData.weathers[0].sunset));
        expect(result.weathers[1].cityName,
            equals(expectedWeekWeatherData.weathers[1].cityName));
        expect(result.weathers[1].latitude,
            equals(expectedWeekWeatherData.weathers[1].latitude));
        expect(result.weathers[1].longitude,
            equals(expectedWeekWeatherData.weathers[1].longitude));
        expect(result.weathers[1].description,
            equals(expectedWeekWeatherData.weathers[1].description));
        expect(result.weathers[1].icon,
            equals(expectedWeekWeatherData.weathers[1].icon));
        expect(result.weathers[1].temperatureActual,
            equals(expectedWeekWeatherData.weathers[1].temperatureActual));
        expect(result.weathers[1].temperatureFeelsLike,
            equals(expectedWeekWeatherData.weathers[1].temperatureFeelsLike));
        expect(result.weathers[1].temperatureMin,
            equals(expectedWeekWeatherData.weathers[1].temperatureMin));
        expect(result.weathers[1].temperatureMax,
            equals(expectedWeekWeatherData.weathers[1].temperatureMax));
        expect(result.weathers[1].humidity,
            equals(expectedWeekWeatherData.weathers[1].humidity));
        expect(result.weathers[1].weatherDate,
            equals(expectedWeekWeatherData.weathers[1].weatherDate));
        expect(result.weathers[1].sunrise,
            equals(expectedWeekWeatherData.weathers[1].sunrise));
        expect(result.weathers[1].sunset,
            equals(expectedWeekWeatherData.weathers[1].sunset));
      },
    );
  });
}
