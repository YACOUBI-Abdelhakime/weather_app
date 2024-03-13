part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {}

/// Get actual weather event
class WeatherActualFetch extends WeatherEvent {
  WeatherActualFetch();

  @override
  List<Object?> get props => [];
}

/// Get week weather event
class WeekWeatherFetch extends WeatherEvent {
  WeekWeatherFetch();

  @override
  List<Object?> get props => [];
}
