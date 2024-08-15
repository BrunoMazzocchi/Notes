import 'package:notes/features/location/domain/entities/location_entity.dart';

abstract class LocalLocationDataSource {
  Future<List<LocationEntity>> getLocation();
  Future<void> saveLocation(LocationEntity locationEntity);
}