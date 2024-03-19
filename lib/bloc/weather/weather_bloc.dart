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

  WeatherBloc({
    required this.locationBloc,
    required this.weatherService,
  }) : super(WeatherState()) {
    // Event responsible for getting the actual weather
    on<WeatherActualFetch>(applyWeatherActualFetchEvent);
    // Event responsible for getting the week weather
    on<WeekWeatherFetch>(applyWeekWeatherFetchEvent);
  }

  /// Event responsible for getting the actual weather
  Future<void> applyWeatherActualFetchEvent(
      WeatherActualFetch event, Emitter<WeatherState> emit) async {
    // set status to loading to start loading
    emit(state.copyWith(status: EventStatus.loading));
    // Call weather service to get weather data
    Weather? weatherResponse = await weatherService.getActualWeatherData(
      latitude: locationBloc.state.latitude,
      longitude: locationBloc.state.longitude,
      cityName: locationBloc.state.cityName,
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
    // Set status to loading to start loading
    emit(state.copyWith(status: EventStatus.loading));
    // Call weather service to get week weather data
    WeekWeather? weekWeatherResponse = await weatherService.getWeekWeatherData(
      latitude: locationBloc.state.latitude,
      longitude: locationBloc.state.longitude,
      cityName: locationBloc.state.cityName,
    );
    // Notify all listener about week weather data
    emit(state.copyWith(
      status: EventStatus.loaded,
      weekWeatherModel: weekWeatherResponse,
    ));
  }
}
