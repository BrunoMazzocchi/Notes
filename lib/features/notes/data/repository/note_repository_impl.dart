import 'package:notes/features/notes/data/datasources/note_datasource.dart';
import 'package:notes/features/notes/domain/entities/note_entity.dart';
import 'package:notes/features/notes/domain/repository/note_repository.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteDatasource _noteDatasource;

  NoteRepositoryImpl({
    required NoteDatasource noteDatasource,
  }) : _noteDatasource = noteDatasource;

  @override
  Future<void> addNote(NoteEntity note) async {
    return _noteDatasource.addNote(note);
  }

  @override
  Future<void> deleteNote(NoteEntity note) async {
    return _noteDatasource.deleteNote(note);
  }

  @override
  Future<List<NoteEntity>> getNotes() {
    return _noteDatasource.getNotes();
  }

  @override
  Future<void> updateNote(NoteEntity note) async {
    return _noteDatasource.updateNote(note);
  }

  @override
  Future<NoteEntity> getNoteById(String noteId) {
    return _noteDatasource.getNoteById(noteId);
  }

  @override
  Stream<List<NoteEntity>> watchNotes() {
    return _noteDatasource.watchNotes();
  }
}
