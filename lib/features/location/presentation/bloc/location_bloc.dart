import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:notes/core/plugins/geo_locator_plugin.dart';

part 'location_event.dart';

part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final GeoLocatorPlugin _geoLocatorPlugin;
  StreamSubscription<Position>? _positionSubscription;

  LocationBloc({
    required GeoLocatorPlugin geoLocatorPlugin,
  })  : _geoLocatorPlugin = geoLocatorPlugin,
        super(LocationInitial()) {
    on<GetLocationEvent>(_onGetLocation);
    _subscribeToLocation();
  }

  void _subscribeToLocation() {
    _positionSubscription = _geoLocatorPlugin.getPositionStream().listen(
      (event) {
        add(GetLocationEvent(event));
      },
    );
  }

  Future<void> _onGetLocation(
      GetLocationEvent event, Emitter<LocationState> emit) async {
    emit(LocationLoading());

    try {
      emit(LocationLoaded(event.position.latitude, event.position.longitude));
    } catch (e) {
      emit(const LocationError('Failed to get location.'));
    }
  }

  @override
  Future<void> close() {
    _positionSubscription?.cancel();
    return super.close();
  }
}
