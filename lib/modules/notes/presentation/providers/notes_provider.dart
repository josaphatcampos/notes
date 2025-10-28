import 'package:flutter/material.dart';

import '../../domain/entities/note.dart';
import '../../domain/entities/note_attachment.dart';
import '../../domain/usecases/add_note.dart';
import '../../domain/usecases/add_note_image.dart';
import '../../domain/usecases/delete_note.dart';
import '../../domain/usecases/get_note_by_id.dart';
import '../../domain/usecases/get_notes.dart';
import '../../domain/usecases/link_note.dart';
import '../../domain/usecases/remove_note_image.dart';
import '../../domain/usecases/search_notes.dart';
import '../../domain/usecases/unlink_note.dart';
import '../../domain/usecases/update_note.dart';

enum NoteSortType {
  titleAsc,
  titleDesc,
  createdAsc,
  createdDesc,
  updatedAsc,
  updatedDesc,
}

class NotesProvider extends ChangeNotifier {
  final GetNotes _getNotes;
  final AddNote _addNote;
  final UpdateNote _updateNote;
  final DeleteNote _deleteNote;
  final LinkNote _linkNote;
  final UnlinkNote _unlinkNote;
  final AddNoteImage _addNoteImage;
  final RemoveNoteImage _removeNoteImage;

  NoteSortType _sortType = NoteSortType.titleAsc;

  NoteSortType get sortType => _sortType;

  NotesProvider({
    required GetNotes getNotes,
    required GetNoteById getNoteById,
    required AddNote addNote,
    required UpdateNote updateNote,
    required DeleteNote deleteNote,
    required SearchNotes searchNotes,
    required LinkNote linkNote,
    required UnlinkNote unlinkNote,
    required AddNoteImage addNoteImage,
    required RemoveNoteImage removeNoteImage,
  }) : _getNotes = getNotes,
       _addNote = addNote,
       _updateNote = updateNote,
       _deleteNote = deleteNote,
       _linkNote = linkNote,
       _unlinkNote = unlinkNote,
       _addNoteImage = addNoteImage,
       _removeNoteImage = removeNoteImage;

  final List<Note> _notes = [];

  List<Note> get notes => List.unmodifiable(_notes);

  Future<void> load() async {
    final list = await _getNotes();
    _notes
      ..clear()
      ..addAll(list..sort((a, b) => b.updatedAt.compareTo(a.updatedAt)));
    notifyListeners();
  }

  Future<void> addNote(Note note) async {
    final saved = await _addNote(note);
    _notes.insert(0, saved);
    notifyListeners();
  }

  Future<void> updateNote(Note updated) async {
    await _updateNote(updated);
    final i = _notes.indexWhere((n) => n.id == updated.id);
    if (i != -1) {
      _notes[i] = updated.copyWith(updatedAt: DateTime.now());
      notifyListeners();
    }
  }

  Future<void> delete(String id) async {
    await _deleteNote(id);
    _notes.removeWhere((n) => n.id == id);
    notifyListeners();
  }

  Note? getById(String id) =>
      _notes.firstWhere((n) => n.id == id, orElse: () => null as Note);

  List<Note> search(String query) {
    if (query.isEmpty) return notes;
    final q = query.toLowerCase();
    return _notes
        .where(
          (n) =>
              n.title.toLowerCase().contains(q) ||
              n.content.toLowerCase().contains(q),
        )
        .toList();
  }

  Future<void> linkNote(String sourceId, String targetId) async {
    await _linkNote(sourceId: sourceId, targetId: targetId);
    final i = _notes.indexWhere((n) => n.id == sourceId);
    if (i != -1) {
      _notes[i] = _notes[i].copyWith(
        linkedNoteIds: [..._notes[i].linkedNoteIds, targetId],
        updatedAt: DateTime.now(),
      );
      notifyListeners();
    }
  }

  List<Note> getNotesByIds(List<String> ids) {
    return _notes.where((note) => ids.contains(note.id)).toList();
  }

  Future<void> unlinkNote(String sourceId, String targetId) async {
    await _unlinkNote(sourceId: sourceId, targetId: targetId);
    final i = _notes.indexWhere((n) => n.id == sourceId);
    if (i != -1) {
      _notes[i] = _notes[i].copyWith(
        linkedNoteIds: _notes[i].linkedNoteIds
            .where((id) => id != targetId)
            .toList(),
        updatedAt: DateTime.now(),
      );
      notifyListeners();
    }
  }

  Future<void> addImage(String noteId, NoteAttachment attachment) async {
    await _addNoteImage(noteId, attachment);
    final i = _notes.indexWhere((n) => n.id == noteId);
    if (i != -1) {
      _notes[i] = _notes[i].copyWith(
        attachments: [..._notes[i].attachments, attachment],
        updatedAt: DateTime.now(),
      );
      notifyListeners();
    }
  }

  Future<void> removeImage(String noteId, String attachmentId) async {
    await _removeNoteImage(noteId, attachmentId);
    final i = _notes.indexWhere((n) => n.id == noteId);
    if (i != -1) {
      _notes[i] = _notes[i].copyWith(
        attachments: _notes[i].attachments
            .where((a) => a.id != attachmentId)
            .toList(),
        updatedAt: DateTime.now(),
      );
      notifyListeners();
    }
  }

  void sortNotes(NoteSortType type) {
    _sortType = type;

    switch (type) {
      case NoteSortType.titleAsc:
        _notes.sort(
          (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
        );
        break;
      case NoteSortType.titleDesc:
        _notes.sort(
          (a, b) => b.title.toLowerCase().compareTo(a.title.toLowerCase()),
        );
        break;
      case NoteSortType.createdAsc:
        _notes.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        break;
      case NoteSortType.createdDesc:
        _notes.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case NoteSortType.updatedAsc:
        _notes.sort((a, b) => a.updatedAt.compareTo(b.updatedAt));
        break;
      case NoteSortType.updatedDesc:
        _notes.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
        break;
    }

    notifyListeners();
  }
}
