import 'package:dartz/dartz.dart';
import 'package:notes/core/network/failure.dart';
import 'package:notes/features/location/domain/entities/location_entity.dart';

abstract class LocationRepository {
  Future<Either<Failure, List<LocationEntity>>> getLocation();
  Future<Either<Failure, void>> saveLocation(LocationEntity locationEntity);
}