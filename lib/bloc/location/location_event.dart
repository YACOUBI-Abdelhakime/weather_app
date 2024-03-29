part of 'location_bloc.dart';

sealed class LocationEvent extends Equatable {}

/// Get current location event
class LocationGetCurrent extends LocationEvent {
  LocationGetCurrent();

  @override
  List<Object?> get props => [];
}

/// Get current location event
class LocationGetSelectedCityName extends LocationEvent {
  LocationGetSelectedCityName();

  @override
  List<Object?> get props => [];
}

/// Get selected cities event
class LocationGetSelectedCities extends LocationEvent {
  LocationGetSelectedCities();

  @override
  List<Object?> get props => [];
}

/// Check if city exists event
class LocationCheckCityIfExists extends LocationEvent {
  final String cityName;
  LocationCheckCityIfExists({required this.cityName});

  @override
  List<Object?> get props => [
        cityName,
      ];
}

/// Update location event
class LocationUpdate extends LocationEvent {
  final double? latitude;
  final double? longitude;
  final String? cityName;
  LocationUpdate({
    this.latitude,
    this.longitude,
    this.cityName,
  });

  @override
  List<Object?> get props => [
        latitude,
        longitude,
        cityName,
      ];
}

/// Check if city exists event
class LocationSelectedCityNameDelete extends LocationEvent {
  final String cityName;
  LocationSelectedCityNameDelete({required this.cityName});

  @override
  List<Object?> get props => [
        cityName,
      ];
}
