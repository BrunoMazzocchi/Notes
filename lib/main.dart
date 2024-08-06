import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:notes/features/notes/data/datasources/note_datasource_impl.dart';
import 'package:notes/features/notes/data/repository/note_repository_impl.dart';
import 'package:notes/features/notes/domain/entities/note_entity.dart';
import 'package:notes/features/notes/domain/repository/note_repository.dart';
import 'package:notes/features/notes/presentation/notes_bloc/notes_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();

  final isar = await Isar.open(
    [NoteEntitySchema],
    directory: dir.path,
  );

  final notesDatasource = NoteDatasourceImpl(
    isar: isar,
  );

  runApp(MyApp(notesDatasource: notesDatasource));
}

class MyApp extends StatelessWidget {
  final NoteDatasourceImpl notesDatasource;

  const MyApp({
    super.key,
    required this.notesDatasource,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<NoteRepository>(
          create: (context) => NoteRepositoryImpl(
            noteDatasource: notesDatasource,
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<NotesBloc>(
            create: (context) => NotesBloc(
              noteRepository: context.read<NoteRepository>(),
            ),
          ),
        ],
        child: const MainApp(),
      ),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                        final note = state.notes[index];
                        context.read<NotesBloc>().add(DeleteNote(note));
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
      ),
    );
  }
}
