import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/location/location_bloc.dart';
import 'package:weather_app/models/enums/event_status.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/models/week_weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final LocationBloc locationBloc;
  final WeatherService weatherService;

  WeatherBloc({required this.locationBloc, required this.weatherService})
      : super(WeatherState()) {
    // Event responsible for getting the actual weather
    on<WeatherActualFetch>(applyWeatherActualFetchEvent);
    on<WeekWeatherFetch>(applyWeekWeatherFetchEvent);
  }

  /// Event responsible for getting the actual weather
  Future<void> applyWeatherActualFetchEvent(
      WeatherActualFetch event, Emitter<WeatherState> emit) async {
    // Quit if location is not available
    if (locationBloc.state.latitude == null ||
        locationBloc.state.longitude == null) {
      return;
    }

    // set status to loading to start loading
    emit(state.copyWith(status: EventStatus.loading));
    // Call weather service to get weather data
    Weather weatherResponse = await weatherService.getActualWeatherData(
      latitude: locationBloc.state.latitude ?? 0,
      longitude: locationBloc.state.longitude ?? 0,
    );
    // Notify all listener about weather data
    emit(state.copyWith(
      status: EventStatus.loaded,
      weatherModel: weatherResponse,
    ));
  }

  /// Event responsible for getting the week weather
  Future<void> applyWeekWeatherFetchEvent(
      WeekWeatherFetch event, Emitter<WeatherState> emit) async {
    // Quit if location is not available
    if (locationBloc.state.latitude == null ||
        locationBloc.state.longitude == null) {
      return;
    }
    // set status to loading to start loading
    emit(state.copyWith(status: EventStatus.loading));
    // Call weather service to get week weather data
    WeekWeather weekWeatherResponse = await weatherService.getWeekWeatherData(
      latitude: locationBloc.state.latitude ?? 0,
      longitude: locationBloc.state.longitude ?? 0,
    );
    // Notify all listener about week weather data
    emit(state.copyWith(
      status: EventStatus.loaded,
      weekWeatherModel: weekWeatherResponse,
    ));
  }
}
