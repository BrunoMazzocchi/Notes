import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/features/notes/domain/entities/note_entity.dart';
import 'package:notes/features/notes/presentation/notes_bloc/notes_bloc.dart';
import 'package:notes/features/notes/presentation/views/note_detail.dart';

class NotesScreen extends StatelessWidget {
  static String routeName = 'notes-screen';
  static String routePath = '/notes-screen';

  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
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
                return GestureDetector(
                  onTap: () {
                    context.push(
                      NoteDetail.routePath,
                      extra: note.id.toString(),
                    );
                  },
                  child: ListTile(
                    title: Text(note.title ?? ''),
                    subtitle: Text(note.content ?? ''),
                    leading: IconButton(
                      icon: note.isFavorite
                          ? const Icon(Icons.star)
                          : const Icon(Icons.star_border),
                      onPressed: () {
                        note.isFavorite = !note.isFavorite;
                        context.read<NotesBloc>().add(UpdateNote(note));
                      },
                    ),
                    trailing: const Icon(Icons.chevron_right),
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
        onPressed: () async {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return const AddNoteBottomSheet();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddNoteBottomSheet extends StatelessWidget {
  const AddNoteBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final titleEditingController = TextEditingController();
    final contentEditingController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          Text(
            'Add Note',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 16),
           TextFormField(
            controller: titleEditingController,
            decoration: const InputDecoration(
              hintText: 'Title',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
           TextFormField(
            controller: contentEditingController,
            decoration: const InputDecoration(
              hintText: 'Content',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () {
              final note = NoteEntity()
                ..title = titleEditingController.text
                ..content = contentEditingController.text;
              context.read<NotesBloc>().add(AddNote(note));
              Navigator.of(context).pop();
            },
            child: const Text('Add Note'),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
