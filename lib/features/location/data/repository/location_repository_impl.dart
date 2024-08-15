import 'package:dartz/dartz.dart';
import 'package:notes/core/network/failure.dart';
import 'package:notes/features/location/data/datasource/local_location_datasource.dart';
import 'package:notes/features/location/domain/entities/location_entity.dart';
import 'package:notes/features/location/domain/repository/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocalLocationDataSource localLocationDataSource;

  LocationRepositoryImpl({required this.localLocationDataSource});

  @override
  Future<Either<Failure, List<LocationEntity>>> getLocation() async {
    try {
      final locationList = await localLocationDataSource.getLocation();
      return Right(locationList);
    } on Exception {
      return Left(LocalDatasourceFailure());
    }
  }

  @override
  Future<Either<Failure, void>> saveLocation(LocationEntity locationEntity) async {
    try {
      await localLocationDataSource.saveLocation(locationEntity);
      return const Right(null);
    } on Exception {
      throw LocalDatasourceFailure();
    }
  }
}
