import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/models/enums/event_status.dart';
import 'package:weather_app/models/weather_model.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherState()) {
    // Event responsible for getting the actual weather
    on<WeatherActualFetch>(applyWeatherActualFetchEvent);
  }

  /// Event responsible for getting the actual weather
  Future<void> applyWeatherActualFetchEvent(
      WeatherActualFetch event, Emitter<WeatherState> emit) async {
    // set status to loading to start loading
    emit(state.copyWith(status: EventStatus.loading));
    // TODO: Call weather service to get weather data

    // Notify all listener about the new issue data
    emit(state.copyWith(
      status: EventStatus.loaded,
    ));
  }
}
