import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'core/config/app_router.dart';
import 'core/config/firebase_options.dart';
import 'core/providers/locale_provider.dart';
import 'core/services/local_storage_service.dart';
import 'l10n/app_localizations.dart';
import 'modules/notes/data/datasources/note_local_datasource.dart';
import 'modules/notes/data/repositories/note_repository_impl.dart';
import 'modules/notes/domain/usecases/add_note.dart';
import 'modules/notes/domain/usecases/add_note_image.dart';
import 'modules/notes/domain/usecases/delete_note.dart';
import 'modules/notes/domain/usecases/get_note_by_id.dart';
import 'modules/notes/domain/usecases/get_notes.dart';
import 'modules/notes/domain/usecases/link_note.dart';
import 'modules/notes/domain/usecases/remove_note_image.dart';
import 'modules/notes/domain/usecases/search_notes.dart';
import 'modules/notes/domain/usecases/unlink_note.dart';
import 'modules/notes/domain/usecases/update_note.dart';
import 'modules/notes/presentation/providers/notes_provider.dart';
import 'shared/design_system/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'pt_PT';

  if (kIsWeb) {
    setUrlStrategy(PathUrlStrategy());
  }

  try {
    await dotenv.load(fileName: ".env");
  } catch (_) {
    debugPrint('⚠️  Env not found');
  }

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await LocalStorageService.init();

  final local = await NoteLocalDataSourceHive.create();
  final repo = NoteRepositoryImpl(local: local);

  final getNotes = GetNotes(repo);
  final getNoteById = GetNoteById(repo);
  final addNote = AddNote(repo);
  final updateNote = UpdateNote(repo);
  final deleteNote = DeleteNote(repo);
  final searchNotes = SearchNotes(repo);
  final linkNote = LinkNote(repo);
  final unlinkNote = UnlinkNote(repo);
  final addNoteImage = AddNoteImage(repo);
  final removeNoteImage = RemoveNoteImage(repo);

  final notesProvider = NotesProvider(
    getNotes: getNotes,
    getNoteById: getNoteById,
    addNote: addNote,
    updateNote: updateNote,
    deleteNote: deleteNote,
    searchNotes: searchNotes,
    linkNote: linkNote,
    unlinkNote: unlinkNote,
    addNoteImage: addNoteImage,
    removeNoteImage: removeNoteImage,
  );

  await notesProvider.load();

  runApp(CocusApp(notesProvider: notesProvider));
}

class CocusApp extends StatelessWidget {
  final NotesProvider notesProvider;

  const CocusApp({super.key, required this.notesProvider});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: notesProvider),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ],
      child: Consumer(
        builder: (context, LocaleProvider localeProvider, _) {
          return MaterialApp.router(
            title: 'Cocus Notes',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            routerConfig: AppRouter.router,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locale: localeProvider.locale,
            localeResolutionCallback: (locale, supportedLocales) {
              for (final supported in supportedLocales) {
                if (supported.languageCode == locale?.languageCode) {
                  return supported;
                }
              }
              return supportedLocales.first;
            },
          );
        },
      ),
    );
  }
}
