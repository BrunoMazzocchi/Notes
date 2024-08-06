import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/features/notes/domain/entities/note_entity.dart';
import 'package:notes/features/notes/domain/repository/note_repository.dart';

part 'note_detail_event.dart';
part 'note_detail_state.dart';

class NoteDetailBloc extends Bloc<NoteDetailEvent, NoteDetailState> {
  final NoteRepository _noteRepository;

  NoteDetailBloc({
    required NoteRepository noteRepository,
  })  : _noteRepository = noteRepository,
        super(NoteDetailInitial()) {
    on<GetNoteDetail>(_getNoteDetail);
    on<DeleteNote>(_deleteNote);
    on<UpdateNote>(_updateNote);
  }

  Future<void> _deleteNote(
      DeleteNote event, Emitter<NoteDetailState> emit) async {
    try {
      emit(NoteDetailLoading());
      await _noteRepository.deleteNote(event.note);
      emit(NoteDeleted());
    } catch (e) {
      emit(NoteDetailError(e.toString()));
    }
  }

  Future<void> _getNoteDetail(
      GetNoteDetail event, Emitter<NoteDetailState> emit) async {
    try {
      emit(NoteDetailLoading());
      final note = await _noteRepository.getNoteById(event.id);
      emit(NoteDetailLoaded(note));
    } catch (e) {
      emit(NoteDetailError(e.toString()));
    }
  }

  Future<void> _updateNote(
      UpdateNote event, Emitter<NoteDetailState> emit) async {
    try {
      emit(NoteDetailLoading());
      await _noteRepository.updateNote(event.note);
      emit(NoteDetailLoaded(event.note));
    } catch (e) {
      emit(NoteDetailError(e.toString()));
    }
  }
}
