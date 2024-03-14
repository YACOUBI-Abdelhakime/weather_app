part of 'location_bloc.dart';

class LocationState extends Equatable {
  /// Event status: loading, loaded, error.
  final EventStatus status;
  final double? latitude;
  final double? longitude;

  const LocationState({
    this.status = EventStatus.initial,
    this.latitude,
    this.longitude,
  });

  /// Constructor by copy
  LocationState copyWith({
    EventStatus? status,
    double? latitude,
    double? longitude,
  }) {
    return LocationState(
      status: status ?? this.status,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  @override
  List<Object?> get props => [
        status,
        latitude,
        longitude,
      ];
}
