import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:notes/core/network/failure.dart';
import 'package:notes/core/usecases/use_case.dart';
import 'package:notes/features/location/domain/entities/location_entity.dart';
import 'package:notes/features/location/domain/repository/location_repository.dart';

class SaveLocationParams {
  final Position position;

  SaveLocationParams(this.position);
}

class SaveLocationUseCase extends UseCase<void, SaveLocationParams> {
  final LocationRepository _repository;

  SaveLocationUseCase({required LocationRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, void>> call(SaveLocationParams params) async {
    final LocationEntity locationEntity = LocationEntity()
      ..latitude = params.position.latitude
      ..longitude = params.position.longitude;

    final checkResult = await _repository.saveLocation(locationEntity);

    return checkResult.fold(
      (failure) => Left(failure),
      (_) => const Right(null),
    );
  }
}
