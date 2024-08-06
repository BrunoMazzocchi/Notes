import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/features/notes/domain/entities/note_entity.dart';
import 'package:notes/features/notes/presentation/note_detail_bloc/note_detail_bloc.dart';

class NoteDetail extends StatefulWidget {
  const NoteDetail({super.key, required this.id});

  static const String routeName = 'note-detail';
  static const String routePath = '/note-detail';

  final String id;

  @override
  State<NoteDetail> createState() => _NoteDetailState();
}

class _NoteDetailState extends State<NoteDetail> {
  NoteEntity? note;

  @override
  void initState() {
    super.initState();
    context.read<NoteDetailBloc>().add(GetNoteDetail(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NoteDetailBloc, NoteDetailState>(
      listener: (context, state) {
        if (state is NoteDetailLoaded) {
          setState(() {
            note = state.note;
          });
        }

        if (state is NoteDeleted) {
          context.pop();
        }

        if (state is NoteDetailError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Note Detail'),
        ),
        body: Center(
          child: Text('Note Detail: ${widget.id}'),
        ),
        floatingActionButton: BlocBuilder<NoteDetailBloc, NoteDetailState>(
          builder: (context, state) {
            
            if (note == null) {
              return const SizedBox.shrink();
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: FloatingActionButton(
                    heroTag: 'delete',
                    onPressed: () {
                      context.read<NoteDetailBloc>().add(DeleteNote(note!));
                    },
                    child: const Icon(Icons.delete),
                  ),
                ),
                FloatingActionButton(
                  heroTag: 'favorite',
                  onPressed: () {
                    note!.isFavorite = !note!.isFavorite;
                    context.read<NoteDetailBloc>().add(UpdateNote(note!));
                  },
                  child: note!.isFavorite
                      ? const Icon(Icons.star)
                      : const Icon(Icons.star_border),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
