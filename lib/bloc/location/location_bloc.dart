import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/models/enums/event_status.dart';
import 'package:weather_app/services/location_service.dart';
import 'package:weather_app/shared/helpers.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationService locationService;
  LocationBloc({required this.locationService}) : super(const LocationState()) {
    // Event responsible for getting the current location
    on<LocationGetCurrent>(applyLocationGetCurrentEvent);
    // Event responsible for checking if city exists
    on<LocationCheckCityIfExists>(applyLocationCheckCityIfExistsEvent);
    // Event responsible for updating the location
    on<LocationUpdate>(applyLocationUpdateEvent);
    // Event responsible for deleting a selected city
    on<LocationSelectedCityNameDelete>(
        applyLocationSelectedCityNameDeleteEvent);
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

  /// Event responsible for getting the week weather
  Future<void> applyLocationCheckCityIfExistsEvent(
      LocationCheckCityIfExists event, Emitter<LocationState> emit) async {
    // Set status to loading to start loading
    emit(state.copyWith(status: EventStatus.loading));
    // Call weather service to get week weather data
    bool isCityExists = await locationService.checkCityNameIfExists(
      cityName: event.cityName,
    );
    if (isCityExists) {
      // Get old selected cities
      Set<String> newSelectedCities = state.selectedCities ?? Set();
      // Add new city to the list
      newSelectedCities.add(Helpers().capitalize(event.cityName));
      // Sort the list alphabetically
      List<String> newSelectedCitiesList = newSelectedCities.toList()..sort();
      newSelectedCities = newSelectedCitiesList.toSet();

      // Notify all listener
      emit(state.copyWith(
        status: EventStatus.loaded,
        selectedCities: newSelectedCities,
      ));
    } else {
      // City not found
      // Notify all listener
      emit(state.copyWith(
        status: EventStatus.error,
        errorMassage: 'Ville non trouvée',
      ));
    }
  }

  /// Event responsible for getting the week weather
  Future<void> applyLocationUpdateEvent(
      LocationUpdate event, Emitter<LocationState> emit) async {
    // Update location data only if city name or coordinates not null
    if (event.cityName != null ||
        (event.latitude != null && event.longitude != null)) {
      // Notify all listener
      emit(state.copyWith(
        latitude: event.latitude,
        longitude: event.longitude,
        cityName: event.cityName,
      ));
    }
  }

  /// Event responsible for getting the week weather
  Future<void> applyLocationSelectedCityNameDeleteEvent(
      LocationSelectedCityNameDelete event, Emitter<LocationState> emit) async {
    // Set status to loading to start loading
    emit(state.copyWith(status: EventStatus.loading));
    // Get old selected cities
    Set<String> selectedCities = state.selectedCities ?? Set();
    // Remove city from the list
    selectedCities.remove(event.cityName);
    // Notify all listener
    emit(state.copyWith(
      status: EventStatus.loaded,
      selectedCities: selectedCities,
    ));
  }
}
