import 'package:dartz/dartz.dart';
import 'package:notes/core/network/failure.dart';
import 'package:notes/features/notes/domain/entities/note_entity.dart';

abstract class NoteRepository {
  Future<List<NoteEntity>> getNotes();
  Future<Either<Failure, void>> addNote(NoteEntity note);
  Future<Either<Failure, void>> updateNote(NoteEntity note);
  Future<void> deleteNote(NoteEntity note);
  Future<NoteEntity> getNoteById(String noteId);
  Stream<List<NoteEntity>> watchNotes();

  // Custom notes stream
  Stream<List<NoteEntity>> watch();
  void dispose();
}
