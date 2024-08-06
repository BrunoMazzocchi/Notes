import 'package:isar/isar.dart';

part 'note_entity.g.dart';

@collection
class NoteEntity {
  Id id = Isar.autoIncrement;
  @Index(type: IndexType.value)
  String? title;

  String? content;

  bool? isPinned;

  @enumerated
  Status status = Status.pending;
}

enum Status {
  draft,
  pending,
  completed,
  deleted,
}
