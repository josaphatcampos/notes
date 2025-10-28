// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Cocus Notes';

  @override
  String get notesTitle => 'My Notes';

  @override
  String get newNote => 'New Note';

  @override
  String get editNote => 'Edit Note';

  @override
  String get title => 'Title';

  @override
  String get close => 'Close';

  @override
  String get linkedNotes => 'Linked Notes';

  @override
  String get emptyNotes => 'No notes yet';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get deleteNoteQuestion => 'Delete Note?';

  @override
  String deleteNoteConfirm(String noteTitle) {
    return 'Are you sure you want to delete the note \"$noteTitle\"?';
  }

  @override
  String get updatedAtLabel => 'Updated at';

  @override
  String get search => 'Search';

  @override
  String get sort => 'Sort';

  @override
  String get sortTitleAsc => 'Title (A-Z)';

  @override
  String get sortTitleDesc => 'Title (Z-A)';

  @override
  String get sortCreatedAsc => 'Creation date ↑';

  @override
  String get sortCreatedDesc => 'Creation date ↓';

  @override
  String get sortUpdatedAsc => 'Last edited ↑';

  @override
  String get sortUpdatedDesc => 'Last edited ↓';

  @override
  String get addImage => 'Add Image';

  @override
  String get linkNotes => 'Link Notes';

  @override
  String get markdownHint => 'Content (Markdown)';

  @override
  String get noTitle => '(Untitled)';

  @override
  String lastUpdated(Object date) {
    return 'Last updated on $date';
  }

  @override
  String get noteNotFound => 'Note not found';

  @override
  String get backToList => 'List';

  @override
  String get attachments => 'Attachments';

  @override
  String get exportPDF => 'Export to PDF';

  @override
  String get deleteNoteWarning => 'This action cannot be undone.';

  @override
  String goToNote(String noteTitle) {
    return 'Go to note \"$noteTitle\"';
  }
}
