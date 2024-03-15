part of 'location_bloc.dart';

sealed class LocationEvent extends Equatable {}

/// Get current location event
class LocationGetCurrent extends LocationEvent {
  LocationGetCurrent();

  @override
  List<Object?> get props => [];
}

/// Check if city exists event
class CheckCityIfExists extends LocationEvent {
  final String cityName;
  CheckCityIfExists({required this.cityName});

  @override
  List<Object?> get props => [
        cityName,
      ];
}
