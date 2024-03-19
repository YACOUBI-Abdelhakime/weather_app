import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/models/week_weather_model.dart';
import 'package:weather_app/repositories/weather_repository.dart';
import 'package:weather_app/services/local_storage_service.dart';
import 'package:weather_app/services/weather_service.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

class MockLocalStorageService extends Mock implements LocalStorageService {}

void main() {
  late MockWeatherRepository mockWeatherRepository;
  late WeatherService weatherService;
  late MockLocalStorageService mockLocalStorageService;

  const testLatitude = 48.8534;
  const testLongitude = 2.3488;
  const testCityName = 'Paris';
  final testWeekWeather = WeekWeather(
    latitude: testLatitude,
    longitude: testLongitude,
    cityName: testCityName,
    sunrise: DateTime.now(),
    sunset: DateTime.now(),
    weathers: [
      Weather(
        latitude: testLatitude,
        longitude: testLongitude,
        cityName: testCityName,
        description: "clear sky",
        icon: "01",
        temperatureActual: 20,
        temperatureFeelsLike: 19,
        temperatureMin: 15,
        temperatureMax: 22,
        humidity: 55,
        sunrise: DateTime(2024, 1, 1, 7, 50, 0),
        sunset: DateTime(2024, 1, 1, 18, 50, 0),
        weatherDate: DateTime(2024, 1, 1, 12),
      ),
      Weather(
        latitude: testLatitude,
        longitude: testLongitude,
        cityName: testCityName,
        description: "few clouds",
        icon: "03",
        temperatureActual: 25,
        temperatureFeelsLike: 24,
        temperatureMin: 20,
        temperatureMax: 27,
        humidity: 90,
        sunrise: DateTime(2024, 1, 1, 7, 50, 0),
        sunset: DateTime(2024, 1, 1, 18, 50, 0),
        weatherDate: DateTime(2024, 1, 1, 3),
      )
    ],
  );
  final testWeather = Weather(
    latitude: testLatitude,
    longitude: testLongitude,
    cityName: testCityName,
    description: "clear sky",
    icon: "01",
    temperatureActual: 20,
    temperatureFeelsLike: 19,
    temperatureMin: 15,
    temperatureMax: 22,
    humidity: 55,
    sunrise: DateTime(2024, 1, 1, 7, 50, 0),
    sunset: DateTime(2024, 1, 1, 18, 50, 0),
    weatherDate: DateTime(2024, 1, 1, 12),
  );

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    mockLocalStorageService = MockLocalStorageService();
    weatherService = WeatherService(
      weatherRepository: mockWeatherRepository,
      localStorageService: mockLocalStorageService,
    );
  });

  group('GetActualWeather tests', () {
    test(
        'getActualWeatherData returns correct weather data for given latitude, longitude, and city name is null',
        () async {
      when(() => mockWeatherRepository.getActualWeatherByCoordinatesDataFromApi(
            latitude: testLatitude,
            longitude: testLongitude,
          )).thenAnswer((_) async {
        return testWeather;
      });

      when(() => mockLocalStorageService.saveWeekWeather(
          weekWeather: testWeekWeather)).thenAnswer((_) async {
        return;
      });

      final Weather? result = await weatherService.getActualWeatherData(
          latitude: testLatitude, longitude: testLongitude, cityName: null);

      expect(result, equals(testWeather));
    });

    test(
        'getActualWeatherData returns correct weather data for given latitude is null, longitude is null, and city name',
        () async {
      when(() => mockWeatherRepository.getActualWeatherDataByCityNameFromApi(
            cityName: testCityName,
          )).thenAnswer((_) async {
        return testWeather;
      });

      when(() => mockLocalStorageService.saveWeekWeather(
          weekWeather: testWeekWeather)).thenAnswer((_) async {
        return;
      });

      final Weather? result = await weatherService.getActualWeatherData(
          latitude: null, longitude: null, cityName: testCityName);

      expect(result, equals(testWeather));
    });
  });

  group('GetWeekWeather tests', () {
    test(
        'getWeekWeatherData returns correct week weather data for given latitude, longitude, and city name is null',
        () async {
      when(() => mockWeatherRepository.getWeekWeatherDataByCoordinatesFromApi(
            latitude: testLatitude,
            longitude: testLongitude,
          )).thenAnswer((_) async {
        return testWeekWeather;
      });

      when(() => mockLocalStorageService.saveWeekWeather(
          weekWeather: testWeekWeather)).thenAnswer((_) async {
        return;
      });

      final WeekWeather? result = await weatherService.getWeekWeatherData(
          latitude: testLatitude, longitude: testLongitude, cityName: null);

      expect(result, equals(testWeekWeather));
    });
    test(
        'getWeekWeatherData returns correct week weather data for given latitude is null, longitude is null, and city name',
        () async {
      when(() => mockWeatherRepository.getWeekWeatherDataByCityNameFromApi(
            cityName: testCityName,
          )).thenAnswer((_) async {
        return testWeekWeather;
      });

      when(() => mockLocalStorageService.saveWeekWeather(
          weekWeather: testWeekWeather)).thenAnswer((_) async {
        return;
      });

      final WeekWeather? result = await weatherService.getWeekWeatherData(
          latitude: null, longitude: null, cityName: testCityName);

      expect(result, equals(testWeekWeather));
    });
  });
}
