part of 'location_bloc.dart';

class LocationState extends Equatable {
  /// Event status: initial, loading, loaded, error.
  final EventStatus status;
  final String? errorMassage;
  final double? latitude;
  final double? longitude;
  final String? cityName;
  final Set<String>? selectedCities;

  const LocationState({
    this.status = EventStatus.initial,
    this.errorMassage,
    this.latitude,
    this.longitude,
    this.cityName,
    this.selectedCities,
  });

  /// Constructor by copy
  LocationState copyWith({
    EventStatus? status,
    String? errorMassage,
    double? latitude,
    double? longitude,
    String? cityName,
    Set<String>? selectedCities,
  }) {
    return LocationState(
      status: status ?? this.status,
      errorMassage: errorMassage ?? this.errorMassage,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      cityName: cityName ?? this.cityName,
      selectedCities: selectedCities ?? this.selectedCities,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMassage,
        latitude,
        longitude,
        cityName,
        selectedCities,
      ];
}
