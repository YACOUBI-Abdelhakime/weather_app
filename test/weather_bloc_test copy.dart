import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/bloc/location/location_bloc.dart';
import 'package:weather_app/bloc/weather/weather_bloc.dart';
import 'package:weather_app/models/enums/event_status.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/models/week_weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class MockCounterBloc extends MockBloc<WeatherEvent, WeatherState>
    implements WeatherBloc {}

class MockLocationBloc extends MockBloc<LocationEvent, LocationState>
    implements LocationBloc {}

class MockWeatherService extends Mock implements WeatherService {}

void main() {
  const double latitude = 48.8534;
  const double longitude = 2.3488;
  const String cityName = 'Paris';
  final Weather testWeather = Weather(
    latitude: latitude,
    longitude: longitude,
    cityName: cityName,
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
  final WeekWeather testWeekWeather = WeekWeather(
    latitude: latitude,
    longitude: longitude,
    cityName: cityName,
    sunrise: DateTime.now(),
    sunset: DateTime.now(),
    weathers: [
      Weather(
        latitude: null,
        longitude: null,
        cityName: null,
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
        latitude: null,
        longitude: null,
        cityName: null,
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

  late MockLocationBloc mockLocationBloc;
  late MockWeatherService mockWeatherService;

  setUp(() {
    mockLocationBloc = MockLocationBloc();
    mockWeatherService = MockWeatherService();
  });

  group('WeatherActualFetch event tests', () {
    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherLoaded with weather model] when successful',
      setUp: () {
        // Mocking the location bloc state
        when(() => mockLocationBloc.state).thenReturn(const LocationState(
          status: EventStatus.loaded,
          latitude: latitude,
          longitude: longitude,
          cityName: cityName,
        ));
        // Mocking the getActualWeatherData method from the weather service
        when(() => mockWeatherService.getActualWeatherData(
            latitude: latitude,
            longitude: longitude,
            cityName: cityName)).thenAnswer((_) async {
          return testWeather;
        });
      },
      build: () => WeatherBloc(
        locationBloc: mockLocationBloc,
        weatherService: mockWeatherService,
      ),
      act: (bloc) => bloc.add(WeatherActualFetch()),
      expect: () => <WeatherState>[
        const WeatherState(
          status: EventStatus.loading,
          weatherModel: null,
          weekWeatherModel: null,
        ),
        WeatherState(
          status: EventStatus.loaded,
          weatherModel: testWeather,
          weekWeatherModel: null,
        ),
      ],
    );
    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherLoaded with weather is null] when cityName is not found',
      setUp: () {
        // Mocking the location bloc state
        when(() => mockLocationBloc.state).thenReturn(const LocationState(
          status: EventStatus.loaded,
          latitude: null,
          longitude: null,
          cityName: "NotFoundCityInTheWorld",
        ));
        // Mocking the getActualWeatherData method from the weather service
        when(
          () => mockWeatherService.getActualWeatherData(
              latitude: null,
              longitude: null,
              cityName: "NotFoundCityInTheWorld"),
        ).thenAnswer((_) async {
          return null;
        });
      },
      build: () => WeatherBloc(
        locationBloc: mockLocationBloc,
        weatherService: mockWeatherService,
      ),
      act: (bloc) => bloc.add(WeatherActualFetch()),
      expect: () => <WeatherState>[
        const WeatherState(
          status: EventStatus.loading,
          weatherModel: null,
          weekWeatherModel: null,
        ),
        const WeatherState(
          status: EventStatus.loaded,
          weatherModel: null,
          weekWeatherModel: null,
        ),
      ],
    );
    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherLoaded with weather model] when latitude is null',
      setUp: () {
        // Mocking the location bloc state
        when(() => mockLocationBloc.state).thenReturn(const LocationState(
          status: EventStatus.loaded,
          latitude: null,
          longitude: longitude,
          cityName: cityName,
        ));
        // Mocking the getActualWeatherData method from the weather service
        when(
          () => mockWeatherService.getActualWeatherData(
            latitude: null,
            longitude: longitude,
            cityName: cityName,
          ),
        ).thenAnswer((_) async {
          return testWeather;
        });
      },
      build: () => WeatherBloc(
        locationBloc: mockLocationBloc,
        weatherService: mockWeatherService,
      ),
      act: (bloc) => bloc.add(WeatherActualFetch()),
      expect: () => <WeatherState>[
        const WeatherState(
          status: EventStatus.loading,
          weatherModel: null,
          weekWeatherModel: null,
        ),
        WeatherState(
          status: EventStatus.loaded,
          weatherModel: testWeather,
          weekWeatherModel: null,
        ),
      ],
    );

    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherLoaded with weather model] when longitude is null',
      setUp: () {
        // Mocking the location bloc state
        when(() => mockLocationBloc.state).thenReturn(const LocationState(
          status: EventStatus.loaded,
          latitude: latitude,
          longitude: null,
          cityName: cityName,
        ));
        // Mocking the getActualWeatherData method from the weather service
        when(
          () => mockWeatherService.getActualWeatherData(
            latitude: latitude,
            longitude: null,
            cityName: cityName,
          ),
        ).thenAnswer((_) async {
          return testWeather;
        });
      },
      build: () => WeatherBloc(
        locationBloc: mockLocationBloc,
        weatherService: mockWeatherService,
      ),
      act: (bloc) => bloc.add(WeatherActualFetch()),
      expect: () => <WeatherState>[
        const WeatherState(
          status: EventStatus.loading,
          weatherModel: null,
          weekWeatherModel: null,
        ),
        WeatherState(
          status: EventStatus.loaded,
          weatherModel: testWeather,
          weekWeatherModel: null,
        ),
      ],
    );
    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherLoaded with weather is null] when latitude, longitude and city name are null',
      setUp: () {
        // Mocking the location bloc state
        when(() => mockLocationBloc.state).thenReturn(const LocationState(
          status: EventStatus.loaded,
          latitude: null,
          longitude: null,
          cityName: null,
        ));
        // Mocking the getActualWeatherData method from the weather service
        when(
          () => mockWeatherService.getActualWeatherData(
            latitude: null,
            longitude: null,
            cityName: null,
          ),
        ).thenAnswer((_) async {
          return null;
        });
      },
      build: () => WeatherBloc(
        locationBloc: mockLocationBloc,
        weatherService: mockWeatherService,
      ),
      act: (bloc) => bloc.add(WeatherActualFetch()),
      expect: () => <WeatherState>[
        const WeatherState(
          status: EventStatus.loading,
          weatherModel: null,
          weekWeatherModel: null,
        ),
        const WeatherState(
          status: EventStatus.loaded,
          weatherModel: null,
          weekWeatherModel: null,
        ),
      ],
    );
  });

  group('WeekWeatherFetch event tests', () {
    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherLoaded with WeekWeather model] when successful',
      setUp: () {
        // Mocking the location bloc state
        when(() => mockLocationBloc.state).thenReturn(const LocationState(
          status: EventStatus.loaded,
          latitude: latitude,
          longitude: longitude,
          cityName: cityName,
        ));
        // Mocking the getWeekWeatherData method from the weather service
        when(() => mockWeatherService.getWeekWeatherData(
            latitude: latitude,
            longitude: longitude,
            cityName: cityName)).thenAnswer((_) async {
          return testWeekWeather;
        });
      },
      build: () => WeatherBloc(
        locationBloc: mockLocationBloc,
        weatherService: mockWeatherService,
      ),
      act: (bloc) => bloc.add(WeekWeatherFetch()),
      expect: () => <WeatherState>[
        const WeatherState(
          status: EventStatus.loading,
          weatherModel: null,
          weekWeatherModel: null,
        ),
        WeatherState(
          status: EventStatus.loaded,
          weatherModel: null,
          weekWeatherModel: testWeekWeather,
        ),
      ],
    );
    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherLoaded with WeekWeather is null] when cityName is not found',
      setUp: () {
        // Mocking the location bloc state
        when(() => mockLocationBloc.state).thenReturn(const LocationState(
          status: EventStatus.loaded,
          latitude: null,
          longitude: null,
          cityName: "NotFoundCityInTheWorld",
        ));
        // Mocking the getWeekWeatherData method from the weather service
        when(() => mockWeatherService.getWeekWeatherData(
            latitude: null,
            longitude: null,
            cityName: "NotFoundCityInTheWorld")).thenAnswer((_) async {
          return null;
        });
      },
      build: () => WeatherBloc(
        locationBloc: mockLocationBloc,
        weatherService: mockWeatherService,
      ),
      act: (bloc) => bloc.add(WeekWeatherFetch()),
      expect: () => <WeatherState>[
        const WeatherState(
          status: EventStatus.loading,
          weatherModel: null,
          weekWeatherModel: null,
        ),
        const WeatherState(
          status: EventStatus.loaded,
          weatherModel: null,
          weekWeatherModel: null,
        ),
      ],
    );
    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherLoaded with WeekWeather model] when latitude is null',
      setUp: () {
        // Mocking the location bloc state
        when(() => mockLocationBloc.state).thenReturn(const LocationState(
          status: EventStatus.loaded,
          latitude: null,
          longitude: longitude,
          cityName: cityName,
        ));
        // Mocking the getWeekWeatherData method from the weather service
        when(() => mockWeatherService.getWeekWeatherData(
            latitude: null,
            longitude: longitude,
            cityName: cityName)).thenAnswer((_) async {
          return testWeekWeather;
        });
      },
      build: () => WeatherBloc(
        locationBloc: mockLocationBloc,
        weatherService: mockWeatherService,
      ),
      act: (bloc) => bloc.add(WeekWeatherFetch()),
      expect: () => <WeatherState>[
        const WeatherState(
          status: EventStatus.loading,
          weatherModel: null,
          weekWeatherModel: null,
        ),
        WeatherState(
          status: EventStatus.loaded,
          weatherModel: null,
          weekWeatherModel: testWeekWeather,
        ),
      ],
    );
    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherLoaded with WeekWeather model] when longitude is null',
      setUp: () {
        // Mocking the location bloc state
        when(() => mockLocationBloc.state).thenReturn(const LocationState(
          status: EventStatus.loaded,
          latitude: latitude,
          longitude: null,
          cityName: cityName,
        ));
        // Mocking the getWeekWeatherData method from the weather service
        when(() => mockWeatherService.getWeekWeatherData(
            latitude: latitude,
            longitude: null,
            cityName: cityName)).thenAnswer((_) async {
          return testWeekWeather;
        });
      },
      build: () => WeatherBloc(
        locationBloc: mockLocationBloc,
        weatherService: mockWeatherService,
      ),
      act: (bloc) => bloc.add(WeekWeatherFetch()),
      expect: () => <WeatherState>[
        const WeatherState(
          status: EventStatus.loading,
          weatherModel: null,
          weekWeatherModel: null,
        ),
        WeatherState(
          status: EventStatus.loaded,
          weatherModel: null,
          weekWeatherModel: testWeekWeather,
        ),
      ],
    );
    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherLoaded with WeekWeather model] when latitude, longitude and city name are null',
      setUp: () {
        // Mocking the location bloc state
        when(() => mockLocationBloc.state).thenReturn(const LocationState(
          status: EventStatus.loaded,
          latitude: null,
          longitude: null,
          cityName: null,
        ));
        // Mocking the getWeekWeatherData method from the weather service
        when(() => mockWeatherService.getWeekWeatherData(
            latitude: null,
            longitude: null,
            cityName: null)).thenAnswer((_) async {
          return null;
        });
      },
      build: () => WeatherBloc(
        locationBloc: mockLocationBloc,
        weatherService: mockWeatherService,
      ),
      act: (bloc) => bloc.add(WeekWeatherFetch()),
      expect: () => <WeatherState>[
        const WeatherState(
          status: EventStatus.loading,
          weatherModel: null,
          weekWeatherModel: null,
        ),
        const WeatherState(
          status: EventStatus.loaded,
          weatherModel: null,
          weekWeatherModel: null,
        ),
      ],
    );
  });
}
