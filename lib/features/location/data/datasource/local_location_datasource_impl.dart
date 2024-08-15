import 'package:isar/isar.dart';
import 'package:notes/features/location/data/datasource/local_location_datasource.dart';
import 'package:notes/features/location/domain/entities/location_entity.dart';

class LocalLocationDataSourceImpl implements LocalLocationDataSource {
  final Isar _isar;

  LocalLocationDataSourceImpl({required Isar isar}) : _isar = isar;


  @override
  Future<List<LocationEntity>> getLocation() async {
    return _isar.locationEntitys.where().findAll();
  }

  @override
  Future<void> saveLocation(LocationEntity locationEntity) async {
    await _isar.writeTxn(() => _isar.locationEntitys.put(locationEntity));
  }
}