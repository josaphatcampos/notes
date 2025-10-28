import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/note.dart';
import '../../domain/entities/note_attachment.dart';
import 'notes_provider.dart';

class NoteEditorProvider extends ChangeNotifier {
  final NotesProvider notesProvider;

  NoteEditorProvider(this.notesProvider);

  Note? _editingNote;
  List<NoteAttachment> attachments = [];
  List<String> linkedNotes = [];
  String title = '';
  String content = '';

  void startEditing(Note? note) {
    _editingNote = note;
    title = note?.title ?? '';
    content = note?.content ?? '';
    attachments = List.from(note?.attachments ?? []);
    linkedNotes = List.from(note?.linkedNoteIds ?? []);
    notifyListeners();
  }

  void updateTitle(String value) {
    title = value;
    notifyListeners();
  }

  void updateContent(String value) {
    content = value;
    notifyListeners();
  }

  void toggleLinkedNote(String noteId) {
    if (linkedNotes.contains(noteId)) {
      linkedNotes.remove(noteId);
    } else {
      linkedNotes.add(noteId);
    }
    notifyListeners();
  }

  Future<void> addImage() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
      withData: true,
    );
    if (result != null && result.files.isNotEmpty) {
      final file = result.files.first;
      final bytes = file.bytes;
      if (bytes != null) {
        final attachment = NoteAttachment(
          id: const Uuid().v4(),
          name: file.name,
          url:
              'data:${file.extension ?? 'image/png'};base64,${base64Encode(bytes)}',
          mimeType: file.extension ?? 'image/png',
          createdAt: DateTime.now(),
        );
        attachments.add(attachment);
        notifyListeners();
        if (_editingNote != null) {
          await notesProvider.addImage(_editingNote!.id, attachment);
        }
      }
    }
  }

  void removeImage(String attachmentId) {
    attachments.removeWhere((a) => a.id == attachmentId);
    if (_editingNote != null) {
      notesProvider.removeImage(_editingNote!.id, attachmentId);
    }
    notifyListeners();
  }

  Future<void> save() async {
    if (title.trim().isEmpty && content.trim().isEmpty) return;
    final now = DateTime.now();
    final note = Note(
      id: _editingNote?.id ?? const Uuid().v4(),
      title: title.trim(),
      content: content.trim(),
      createdAt: _editingNote?.createdAt ?? now,
      updatedAt: now,
      attachments: attachments,
      linkedNoteIds: linkedNotes,
    );
    if (_editingNote == null) {
      await notesProvider.addNote(note);
    } else {
      await notesProvider.updateNote(note);
    }
  }
}
