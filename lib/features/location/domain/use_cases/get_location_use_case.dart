import 'package:dartz/dartz.dart';
import 'package:notes/core/network/failure.dart';
import 'package:notes/core/usecases/use_case.dart';
import 'package:notes/features/location/domain/entities/location_entity.dart';
import 'package:notes/features/location/domain/repository/location_repository.dart';

class GetLocationUseCase extends UseCase<List<LocationEntity>, NoParams> {
  final LocationRepository _repository;

  GetLocationUseCase({required LocationRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, List<LocationEntity>>> call(NoParams params) async {
    final checkResult = await _repository.getLocation();

    return checkResult.fold(
      (failure) => Left(failure),
      (locationList) => Right(locationList),
    );
  }
}
