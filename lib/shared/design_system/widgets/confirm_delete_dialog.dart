import 'package:cocus/l10n/app_localizations.dart';
import 'package:cocus/shared/design_system/components/ds_button.dart';
import 'package:cocus/shared/design_system/components/ds_dialog.dart';
import 'package:flutter/material.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  final String noteTitle;
  final VoidCallback onConfirm;
  final String? description;

  const ConfirmDeleteDialog({
    super.key,
    required this.noteTitle,
    required this.onConfirm,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return DSDialog(
      title: loc.deleteNoteQuestion,
      message: description ?? loc.deleteNoteConfirm(noteTitle),
      confirmLabel: loc.delete,
      cancelLabel: loc.cancel,
      onConfirm: onConfirm,
      confirmType: DSButtonType.danger,
    );
  }
}
