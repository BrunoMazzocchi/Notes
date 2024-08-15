part of 'historic_location_bloc.dart';

sealed class HistoricLocationState extends Equatable {
  const HistoricLocationState();

  @override
  List<Object> get props => [];
}

final class HistoricLocationInitial extends HistoricLocationState {}

final class HistoricLocationLoading extends HistoricLocationState {}

final class HistoricLocationLoaded extends HistoricLocationState {
  final List<LocationEntity> locationList;

  const HistoricLocationLoaded(this.locationList);

  @override
  List<Object> get props => [locationList];
}

final class HistoricLocationError extends HistoricLocationState {
  final String message;

  const HistoricLocationError(this.message);

  @override
  List<Object> get props => [message];
}

final class HistoricLocationSaved extends HistoricLocationState {}
