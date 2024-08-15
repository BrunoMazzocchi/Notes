import 'package:dartz/dartz.dart';
import 'package:notes/core/network/failure.dart';
import 'package:notes/core/usecases/use_case.dart';
import 'package:notes/features/notes/domain/entities/note_entity.dart';
import 'package:notes/features/notes/domain/repository/note_repository.dart';

class AddNoteParams {
  final NoteEntity note;

  AddNoteParams({
    required this.note,
  });
}

class AddNoteUseCase extends UseCase<void, AddNoteParams> {
  final NoteRepository _repository;

  AddNoteUseCase({
    required NoteRepository repository,
  }) : _repository = repository;

  @override
  Future<Either<Failure, void>> call(AddNoteParams params) {
    return _repository.addNote(params.note);
  }
}