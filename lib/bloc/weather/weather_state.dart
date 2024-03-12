part of 'weather_bloc.dart';

class WeatherState extends Equatable {
  /// Weather status: loading, loaded, error.
  final EventStatus status;

  /// Actual weather model
  final Weather? weatherModel;

  const WeatherState({
    this.status = EventStatus.initial,
    this.weatherModel,
  });

  /// Constructor by copy
  WeatherState copyWith({
    EventStatus? status,
    Weather? weatherModel,
  }) {
    return WeatherState(
      status: status ?? this.status,
      weatherModel: weatherModel ?? this.weatherModel,
    );
  }

  @override
  List<Object?> get props => [
        status,
        weatherModel,
      ];
}
