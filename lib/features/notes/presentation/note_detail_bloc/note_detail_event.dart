part of 'note_detail_bloc.dart';

abstract class NoteDetailEvent extends Equatable {
  const NoteDetailEvent();

  @override
  List<Object> get props => [];
}

class GetNoteDetail extends NoteDetailEvent {
  final String id;

  const GetNoteDetail(this.id);

  @override
  List<Object> get props => [id];
}

class UpdateNote extends NoteDetailEvent {
  final NoteEntity note;

  const UpdateNote(this.note);

  @override
  List<Object> get props => [note];
}

class DeleteNote extends NoteDetailEvent {
  final NoteEntity note;

  const DeleteNote(this.note);

  @override
  List<Object> get props => [note];
}

class CreateNote extends NoteDetailEvent {
  final NoteEntity note;

  const CreateNote(this.note);

  @override
  List<Object> get props => [note];
}