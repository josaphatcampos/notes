import 'package:go_router/go_router.dart';

import '../../modules/notes/domain/entities/note.dart';
import '../../modules/notes/presentation/note_detail_page.dart';
import '../../modules/notes/presentation/note_edit_page.dart';
import '../../modules/notes/presentation/notes_list_page.dart';

class AppRoutes {
  static const String notesListPath = '/';
  static const String noteDetailPath = '/notes/:id';
  static const String editNotePath = '/edit-note';
  static const String newNotePath = '/new-note';

  static const String notesListName = 'notes_list';
  static const String noteDetailName = 'note_detail';
  static const String editNoteName = 'edit_note';
  static const String newNoteName = 'new_note';
}

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.notesListPath,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: AppRoutes.notesListPath,
        name: AppRoutes.notesListName,
        builder: (context, state) => const NotesListPage(),
      ),
      GoRoute(
        path: AppRoutes.noteDetailPath,
        name: AppRoutes.noteDetailName,
        builder: (context, state) {
          final noteId = state.pathParameters['id']!;
          return NoteDetailPage(noteId: noteId);
        },
      ),
      GoRoute(
        path: AppRoutes.editNotePath,
        name: AppRoutes.editNoteName,
        builder: (context, state) {
          final note = state.extra is Note ? state.extra as Note : null;
          return NoteEditPage(note: note);
        },
      ),
      GoRoute(
        path: AppRoutes.newNotePath,
        name: AppRoutes.newNoteName,
        builder: (context, state) => const NoteEditPage(),
      ),
    ],
  );
}
