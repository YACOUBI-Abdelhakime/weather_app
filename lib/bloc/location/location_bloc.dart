import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/models/enums/event_status.dart';
import 'package:weather_app/services/location_service.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationService locationService;
  LocationBloc({required this.locationService}) : super(const LocationState()) {
    // Event responsible for getting the current location
    on<LocationGetCurrent>(applyLocationGetCurrentEvent);
  }

  /// Event responsible for getting the current location
  Future<void> applyLocationGetCurrentEvent(
      LocationGetCurrent event, Emitter<LocationState> emit) async {
    // set status to loading to start loading
    emit(state.copyWith(status: EventStatus.loading));
    double latitude, longitude;
    // Call weather service to get weather data
    (latitude, longitude) = await locationService.getCurrentLocation();
    // Notify all listener about location data
    emit(state.copyWith(
      status: EventStatus.loaded,
      latitude: latitude,
      longitude: longitude,
    ));
  }
}
