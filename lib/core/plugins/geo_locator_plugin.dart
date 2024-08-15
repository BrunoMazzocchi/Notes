import 'package:geolocator/geolocator.dart';

class GeoLocatorPlugin {
  Future<void> _handlePermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied');
    }
  }

  Stream<Position> getPositionStream() async* {
    await _handlePermission();

    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 0,
    );

    yield* Geolocator.getPositionStream(locationSettings: locationSettings);
  }
}
