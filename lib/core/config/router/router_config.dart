import 'package:go_router/go_router.dart';
import 'package:notes/features/notes/presentation/views/note_detail.dart';
import 'package:notes/features/notes/presentation/views/notes_screen.dart';
import 'package:notes/features/presentation/view/pages/home_screen.dart';

final goRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'notes-screen',
          builder: (context, state) => const NotesScreen(),
        ),
        GoRoute(
          path: 'note-detail',
          builder: (context, state) {
            final id = state.extra as String;
            return NoteDetail(id: id);
          },
        ),
      ],
    ),
  ],
);
