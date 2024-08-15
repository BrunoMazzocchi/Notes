import 'package:dartz/dartz.dart';
import 'package:notes/core/network/failure.dart';
import 'package:notes/core/usecases/use_case.dart';
import 'package:notes/features/notes/domain/entities/note_entity.dart';
import 'package:notes/features/notes/domain/repository/note_repository.dart';

class UpdateNoteparams {
  final NoteEntity note;

  UpdateNoteparams({
    required this.note,
  });
}

class UpdateNoteUseCase extends UseCase<void, UpdateNoteparams> {
  final NoteRepository _repository;

  UpdateNoteUseCase({
    required NoteRepository repository,
  }) : _repository = repository;

  @override
  Future<Either<Failure, void>> call(UpdateNoteparams params) {
    return _repository.updateNote(params.note);
  }
}