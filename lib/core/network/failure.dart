import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class ServerFailure extends Failure {
  final Object? error;

  ServerFailure({
    this.error,
  });

  @override
  List<Object?> get props => [error];
}

class ReachedMaxLimitFailure extends Failure {
  final Object? error;

  ReachedMaxLimitFailure({
    this.error,
  });

  @override
  List<Object?> get props => [error];
}

class LocalDatasourceFailure extends Failure {
  final Object? error;

  LocalDatasourceFailure({
    this.error,
  });

  @override
  List<Object?> get props => [error];
}