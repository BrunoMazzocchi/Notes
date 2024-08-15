part of 'location_bloc.dart';

sealed class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

final class GetLocationEvent extends LocationEvent {
  final Position position;

  const GetLocationEvent(this.position);

  @override
  List<Object> get props => [position];
}

final class GetLocationPermissionEvent extends LocationEvent {}

final class GetLocationServiceEvent extends LocationEvent {}