import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../modules/notes/domain/entities/note.dart';
import '../config/app_router.dart';

extension ContextNavigation on BuildContext {
  void goToHome() => go(AppRoutes.notesListPath);
  void goToNewNote() => goNamed(AppRoutes.newNoteName);
  void goToEdit(Note note) => goNamed(AppRoutes.editNoteName, extra: note);
  void goToDetail(String id) =>
      goNamed(AppRoutes.noteDetailName, pathParameters: {'id': id});
}
