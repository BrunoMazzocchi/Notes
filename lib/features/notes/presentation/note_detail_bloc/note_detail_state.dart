part of 'note_detail_bloc.dart';

abstract class NoteDetailState extends Equatable {
  const NoteDetailState();

  @override
  List<Object> get props => [];
}

class NoteDetailInitial extends NoteDetailState {}

class NoteDetailLoading extends NoteDetailState {}

class NoteDetailLoaded extends NoteDetailState {
  final NoteEntity note;

  const NoteDetailLoaded(this.note);

  @override
  List<Object> get props => [note];
}

class NoteDetailError extends NoteDetailState {
  final String message;

  const NoteDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class NoteDeleted extends NoteDetailState {}