import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:notes/core/network/failure.dart';
import 'package:notes/core/usecases/stream_use_case.dart';
import 'package:notes/features/notes/domain/entities/note_entity.dart';
import 'package:notes/features/notes/domain/repository/note_repository.dart';

class WatchFavoritesUseCase
    extends StreamUseCase<List<NoteEntity>, NoParamsStream> {
  final NoteRepository _repository;

  WatchFavoritesUseCase({
    required NoteRepository repository,
  }) : _repository = repository;

  @override
  Stream<Either<Failure, List<NoteEntity>>> call(NoParamsStream params) {
    return _repository.watch().map((notes) {
      debugPrint(notes.toString());
      return Right(notes);
    });
  }
}
