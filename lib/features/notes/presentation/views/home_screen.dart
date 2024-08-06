import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/features/notes/domain/entities/note_entity.dart';
import 'package:notes/features/notes/presentation/notes_bloc/notes_bloc.dart';
import 'package:notes/features/notes/presentation/views/note_detail.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = '/home';
  static String routePath = '/';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<NotesBloc, NotesState>(
        listener: (context, state) {
          if (state is NotesError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is NotesInitial) {
            context.read<NotesBloc>().add(GetNotes());
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is NotesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is NotesLoaded) {
            if (state.notes.isEmpty) {
              return const Center(
                child: Text('No notes found'),
              );
            }

            return ListView.builder(
              itemCount: state.notes.length,
              itemBuilder: (context, index) {
                final note = state.notes[index];
                return ListTile(
                  title: Text(note.title ?? ''),
                  subtitle: Text(note.content ?? ''),
                  trailing: IconButton(
                    icon: const Icon(Icons.chevron_right),
                    onPressed: () {
                      context.push(
                        NoteDetail.routePath,
                        extra: note.id.toString(),
                      );
                    },
                  ),
                );
              },
            );
          } else if (state is NotesError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final note = NoteEntity()
            ..title = 'Title'
            ..content = 'Content';
          context.read<NotesBloc>().add(
                AddNote(note),
              );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
