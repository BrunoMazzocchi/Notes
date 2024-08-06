import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/features/notes/domain/entities/note_entity.dart';
import 'package:notes/features/notes/domain/repository/note_repository.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NoteRepository _noteRepository;
  StreamSubscription<List<NoteEntity>>? _notesSubscription;

  NotesBloc({
    required NoteRepository noteRepository,
  })  : _noteRepository = noteRepository,
        super(NotesInitial()) {
    on<GetNotes>(_getNotes);
    on<AddNote>(_addNote);
    on<UpdateNote>(_updateNote);
    on<DeleteNote>(_deleteNote);
    on<NotesUpdated>(_mapNotesUpdatedToState);
    _subscribeToNotes();
  }

  void _mapNotesUpdatedToState(NotesUpdated event, Emitter<NotesState> emit) {
    emit(NotesLoaded(event.notes));
  }

  void _subscribeToNotes() {
    _notesSubscription = _noteRepository.watchNotes().listen((notes) {
      add(NotesUpdated(notes)); 
    });
  }

  Future<void> _getNotes(GetNotes event, Emitter<NotesState> emit) async {
    try {
      emit(NotesLoading());
      final notes = await _noteRepository.getNotes();
      emit(NotesLoaded(notes));
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> _addNote(AddNote event, Emitter<NotesState> emit) async {
    try {
      emit(NotesLoading());
      await _noteRepository.addNote(event.note);
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> _updateNote(UpdateNote event, Emitter<NotesState> emit) async {
    try {
      emit(NotesLoading());
      await _noteRepository.updateNote(event.note);
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> _deleteNote(DeleteNote event, Emitter<NotesState> emit) async {
    try {
      emit(NotesLoading());
      await _noteRepository.deleteNote(event.note);
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _notesSubscription?.cancel();
    return super.close();
  }
}
