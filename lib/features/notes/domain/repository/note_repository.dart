import 'package:notes/features/notes/domain/entities/note_entity.dart';

abstract class NoteRepository {
  Future<List<NoteEntity>> getNotes();
  Future<void> addNote(NoteEntity note);
  Future<void> updateNote(NoteEntity note);
  Future<void> deleteNote(NoteEntity note);
  Future<NoteEntity> getNoteById(String noteId);
  Stream<List<NoteEntity>> watchNotes();

  // Custom notes stream 
  Stream<List<NoteEntity>> watch();
  void dispose();
}
