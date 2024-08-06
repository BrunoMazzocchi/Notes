import 'package:isar/isar.dart';
import 'package:notes/features/notes/data/datasources/note_datasource.dart';
import 'package:notes/features/notes/domain/entities/note_entity.dart';

class NoteDatasourceImpl implements NoteDatasource {
  final Isar _isar;

  NoteDatasourceImpl({
    required Isar isar,
  }) : _isar = isar;

  @override
  Future<void> addNote(NoteEntity note) async {
    await _isar.writeTxn(() => _isar.noteEntitys.put(note));
  }

  @override
  Future<void> deleteNote(NoteEntity note) async {
    await _isar.writeTxn(() => _isar.noteEntitys.delete(note.id));
  }

  @override
  Future<List<NoteEntity>> getNotes() async {
    final notes = await _isar.noteEntitys.where().findAll();

    return notes;
  }

  @override
  Future<void> updateNote(NoteEntity note) async {
    await _isar.writeTxn(() => _isar.noteEntitys.put(note));
  }

  @override
  Future<NoteEntity> getNoteById(String noteId) async {
    final note = await _isar.noteEntitys.get(int.parse(noteId));

    return note!;
  }
}
