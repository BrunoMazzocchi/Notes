import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:notes/core/config/router/router_config.dart';
import 'package:notes/features/notes/data/datasources/note_datasource_impl.dart';
import 'package:notes/features/notes/data/repository/note_repository_impl.dart';
import 'package:notes/features/notes/domain/entities/note_entity.dart';
import 'package:notes/features/notes/domain/repository/note_repository.dart';
import 'package:notes/features/notes/domain/use_cases/add_note_use_case.dart';
import 'package:notes/features/notes/domain/use_cases/update_note_use_case.dart';
import 'package:notes/features/notes/domain/use_cases/watch_notes_use_case.dart';
import 'package:notes/features/notes/presentation/note_detail_bloc/note_detail_bloc.dart';
import 'package:notes/features/notes/presentation/notes_bloc/notes_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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
              watchFavoritesUseCase: WatchFavoritesUseCase(
                repository: context.read<NoteRepository>(),
              ),
              addNoteUseCase: AddNoteUseCase(
                repository: context.read<NoteRepository>(),
              ),
              updateNoteUseCase: UpdateNoteUseCase(
                repository: context.read<NoteRepository>(),
              ),
            ),
          ),
          BlocProvider<NoteDetailBloc>(
            create: (context) => NoteDetailBloc(
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
    return ResponsiveSizer(
      builder: (context, orientation, screenType) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: goRouter,
      ),
    );
  }
}
