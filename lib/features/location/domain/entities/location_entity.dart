import 'package:isar/isar.dart';

part 'location_entity.g.dart';

@collection
class LocationEntity {
  Id id = Isar.autoIncrement;

  double? speed;
  double? latitude;
  double? longitude;
}
