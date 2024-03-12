
part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {}

/// Get one issue
class WeatherActualFetch extends WeatherEvent {
  WeatherActualFetch();

  @override
  List<Object?> get props => [];
}
