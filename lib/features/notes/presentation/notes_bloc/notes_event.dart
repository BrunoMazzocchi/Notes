part of 'notes_bloc.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object> get props => [];
}

class GetNotes extends NotesEvent {}

class AddNote extends NotesEvent {
  final NoteEntity note;

  const AddNote(this.note);

  @override
  List<Object> get props => [note];
}

class UpdateNote extends NotesEvent {
  final NoteEntity note;

  const UpdateNote(this.note);

  @override
  List<Object> get props => [note];
}

class DeleteNote extends NotesEvent {
  final NoteEntity note;

  const DeleteNote(this.note);

  @override
  List<Object> get props => [note];
}