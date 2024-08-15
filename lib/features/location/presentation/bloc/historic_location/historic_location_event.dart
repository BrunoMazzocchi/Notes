part of 'historic_location_bloc.dart';

sealed class HistoricLocationEvent extends Equatable {
  const HistoricLocationEvent();

  @override
  List<Object?> get props => [];
}

final class GetHistoricLocationEvent extends HistoricLocationEvent {}

final class SaveHistoricLocationEvent extends HistoricLocationEvent {
  final Position position;
  final VoidCallback? action;

  const SaveHistoricLocationEvent(this.position, {this.action});

  @override
  List<Object?> get props => [position];
}