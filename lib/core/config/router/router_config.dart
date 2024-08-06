import 'package:go_router/go_router.dart';
import 'package:notes/features/notes/presentation/views/home_screen.dart';
import 'package:notes/features/notes/presentation/views/note_detail.dart';

final goRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: NoteDetail.routePath,
      builder: (context, state) {
        final id = state.extra as String;
        return NoteDetail(id: id);
      },
    ),
  ],
);
