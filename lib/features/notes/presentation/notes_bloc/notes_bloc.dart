import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/core/network/failure.dart';
import 'package:notes/core/usecases/stream_use_case.dart';
import 'package:notes/features/notes/domain/entities/note_entity.dart';
import 'package:notes/features/notes/domain/use_cases/add_note_use_case.dart';
import 'package:notes/features/notes/domain/use_cases/update_note_use_case.dart';
import 'package:notes/features/notes/domain/use_cases/watch_notes_use_case.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  StreamSubscription<Either<Failure, List<NoteEntity>>>? _notesSubscription;

  final WatchFavoritesUseCase _watchFavoritesUseCase;
  final AddNoteUseCase _addNoteUseCase;
  final UpdateNoteUseCase _updateNoteUseCase;

  NotesBloc({
    required WatchFavoritesUseCase watchFavoritesUseCase,
    required AddNoteUseCase addNoteUseCase,
    required UpdateNoteUseCase updateNoteUseCase,
  })  : _watchFavoritesUseCase = watchFavoritesUseCase,
        _updateNoteUseCase = updateNoteUseCase,
        _addNoteUseCase = addNoteUseCase,
        super(NotesInitial()) {
    on<AddNote>(_addNote);
    on<NotesUpdated>(_mapNotesUpdatedToState);
    on<UpdateNote>(_updateNote);
    _subscribeToNotes();
  }

  void _mapNotesUpdatedToState(NotesUpdated event, Emitter<NotesState> emit) {
    emit(NotesLoaded(event.notes));
  }

  void _subscribeToNotes() {
    _notesSubscription = _watchFavoritesUseCase(NoParamsStream()).listen(
      (either) {
        either.fold(
          (failure) => {},
          (notes) => add(NotesUpdated(notes)),
        );
      },
    );
  }

  Future<void> _addNote(AddNote event, Emitter<NotesState> emit) async {
    try {
      emit(NotesLoading());
      await _addNoteUseCase(AddNoteParams(note: event.note));
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> _updateNote(UpdateNote event, Emitter<NotesState> emit) async {
    try {
      emit(NotesLoading());
      await _updateNoteUseCase(UpdateNoteparams(note: event.note));
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
