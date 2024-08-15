import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:notes/core/usecases/use_case.dart';
import 'package:notes/features/location/domain/entities/location_entity.dart';
import 'package:notes/features/location/domain/use_cases/get_location_use_case.dart';
import 'package:notes/features/location/domain/use_cases/save_locatino_use_case.dart';

part 'historic_location_event.dart';
part 'historic_location_state.dart';

class HistoricLocationBloc
    extends Bloc<HistoricLocationEvent, HistoricLocationState> {
  final GetLocationUseCase _getLocationUseCase;
  final SaveLocationUseCase _saveLocationUseCase;

  HistoricLocationBloc({
    required GetLocationUseCase getLocationUseCase,
    required SaveLocationUseCase saveLocationUseCase,
  })  : _getLocationUseCase = getLocationUseCase,
        _saveLocationUseCase = saveLocationUseCase,
        super(HistoricLocationInitial()) {
    on<GetHistoricLocationEvent>(_onGetHistoricLocation);
    on<SaveHistoricLocationEvent>(_onSaveHistoricLocation);
  }

  Future<void> _onGetHistoricLocation(
      GetHistoricLocationEvent event, Emitter<HistoricLocationState> emit) async {
    emit(HistoricLocationLoading());

    final result = await _getLocationUseCase.call(NoParams());

    result.fold(
      (failure) => emit(const HistoricLocationError('Failed to get location.')),
      (location) => emit(HistoricLocationLoaded(location)),
    );
  }

  Future<void> _onSaveHistoricLocation(
      SaveHistoricLocationEvent event, Emitter<HistoricLocationState> emit) async {
    emit(HistoricLocationLoading());

    final result = await _saveLocationUseCase.call(SaveLocationParams(event.position));

    result.fold(
      (failure) => emit(const HistoricLocationError('Failed to save location.')),
      (_) {
        emit(HistoricLocationSaved());

        event.action?.call();
      },
    );
  }
}
