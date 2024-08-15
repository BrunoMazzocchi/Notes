import 'package:dartz/dartz.dart';
import 'package:notes/core/network/failure.dart';

abstract class StreamUseCase<Type, NoParamsStream> {
  Stream<Either<Failure, Type>> call(NoParamsStream params);
}

class NoParamsStream {}
