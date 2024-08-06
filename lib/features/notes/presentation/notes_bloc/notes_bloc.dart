import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/features/notes/domain/entities/note_entity.dart';
import 'package:notes/features/notes/domain/repository/note_repository.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NoteRepository _noteRepository;

  NotesBloc({
    required NoteRepository noteRepository,
  })  : _noteRepository = noteRepository,
        super(NotesInitial()) {
    on<GetNotes>(_getNotes);
    on<AddNote>(_addNote);
    on<UpdateNote>(_updateNote);
    on<DeleteNote>(_deleteNote);
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
      final notes = await _noteRepository.getNotes();
      emit(NotesLoaded(notes));
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> _updateNote(UpdateNote event, Emitter<NotesState> emit) async {
    try {
      emit(NotesLoading());
      await _noteRepository.updateNote(event.note);
      final notes = await _noteRepository.getNotes();
      emit(NotesLoaded(notes));
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> _deleteNote(DeleteNote event, Emitter<NotesState> emit) async {
    try {
      emit(NotesLoading());
      await _noteRepository.deleteNote(event.note);
      final notes = await _noteRepository.getNotes();
      emit(NotesLoaded(notes));
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }
}
