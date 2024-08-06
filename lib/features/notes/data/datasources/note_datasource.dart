import 'package:notes/features/notes/domain/entities/note_entity.dart';

abstract class NoteDatasource {
  Future<List<NoteEntity>> getNotes();
  Future<void> addNote(NoteEntity note);
  Future<void> updateNote(NoteEntity note);
  Future<void> deleteNote(NoteEntity note);
}
