import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:notes/core/network/failure.dart';
import 'package:notes/features/notes/data/datasources/note_datasource.dart';
import 'package:notes/features/notes/domain/entities/note_entity.dart';
import 'package:notes/features/notes/domain/repository/note_repository.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteDatasource _noteDatasource;
  final _notesStreamController = StreamController<List<NoteEntity>>.broadcast();

  NoteRepositoryImpl({
    required NoteDatasource noteDatasource,
  }) : _noteDatasource = noteDatasource {
    _init();
  }

  void _init() {
    _loadAndEmitNotes();
  }

  Future<void> _loadAndEmitNotes() async {
    try {
      final notes = await _noteDatasource.getNotes();
      _notesStreamController.add(notes);
    } catch (e) {
      _notesStreamController.addError(e);
    }
  }

  @override
  Future<Either<Failure, void>> addNote(NoteEntity note) async {
    try {
      await _noteDatasource.addNote(note);
      _loadAndEmitNotes();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<void> deleteNote(NoteEntity note) async {
    await _noteDatasource.deleteNote(note);
    _loadAndEmitNotes();
  }

  @override
  Future<List<NoteEntity>> getNotes() {
    return _noteDatasource.getNotes();
  }

  @override
  Future<Either<Failure, void>> updateNote(NoteEntity note) async {
    try {
      await _noteDatasource.updateNote(note);
      _loadAndEmitNotes();
      return const Right(null);
    } catch (e) {
      throw ServerFailure();
    }
  }

  @override
  Future<NoteEntity> getNoteById(String noteId) {
    return _noteDatasource.getNoteById(noteId);
  }

  @override
  Stream<List<NoteEntity>> watch() {
    return _notesStreamController.stream;
  }

  @override
  void dispose() {
    _notesStreamController.close();
  }

  @override
  Stream<List<NoteEntity>> watchNotes() {
    return _noteDatasource.watchNotes();
  }
}
