part of 'location_bloc.dart';

sealed class LocationEvent extends Equatable {}

/// Get current location event
class LocationGetCurrent extends LocationEvent {
  LocationGetCurrent();

  @override
  List<Object?> get props => [];
}
