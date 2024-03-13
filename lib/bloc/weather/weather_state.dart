part of 'weather_bloc.dart';

class WeatherState extends Equatable {
  /// Weather status: loading, loaded, error.
  final EventStatus status;

  /// Actual weather model
  final Weather? weatherModel;

  /// Week weather model  (5 days)
  final WeekWeather? weekWeatherModel;

  const WeatherState({
    this.status = EventStatus.initial,
    this.weatherModel,
    this.weekWeatherModel,
  });

  /// Get day weathers
  List<Weather> getDayWeathers() {
    List<Weather> dayWeathers = [];
    if (weekWeatherModel == null) {
      return [];
    }
    for (Weather weather in weekWeatherModel?.weathers ?? []) {
      if (weather.weatherDate.day == DateTime.now().day) {
        dayWeathers.add(weather);
      } else {
        break;
      }
    }

    return dayWeathers;
  }

  /// Get all weathers expect the current day
  List<Weather> getAllWeathersExpectTodaysWeather() {
    List<Weather> dayWeathers = [];
    if (weekWeatherModel == null) {
      return [];
    }
    for (Weather weather in weekWeatherModel?.weathers ?? []) {
      if (weather.weatherDate.day != DateTime.now().day) {
        dayWeathers.add(weather);
      }
    }

    return dayWeathers;
  }

  /// Constructor by copy
  WeatherState copyWith({
    EventStatus? status,
    Weather? weatherModel,
    WeekWeather? weekWeatherModel,
  }) {
    return WeatherState(
      status: status ?? this.status,
      weatherModel: weatherModel ?? this.weatherModel,
      weekWeatherModel: weekWeatherModel ?? this.weekWeatherModel,
    );
  }

  @override
  List<Object?> get props => [
        status,
        weatherModel,
        weekWeatherModel,
      ];
}
