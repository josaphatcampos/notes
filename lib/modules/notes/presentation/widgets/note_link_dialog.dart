import 'package:cocus/l10n/app_localizations.dart';
import 'package:cocus/modules/notes/domain/entities/note.dart';
import 'package:cocus/modules/notes/presentation/providers/note_editor_provider.dart';
import 'package:cocus/shared/design_system/theme/ds_spacing.dart';
import 'package:cocus/shared/design_system/theme/ds_typography.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../shared/design_system/components/ds_button.dart';

class NoteLinkDialog extends StatelessWidget {
  final List<Note> allNotes;
  final NoteEditorProvider editor;

  const NoteLinkDialog({
    super.key,
    required this.allNotes,
    required this.editor,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final typo = Theme.of(context).extension<DSTypography>()!;
    final spacing = Theme.of(context).extension<DSSpacing>()!;
    final color = Theme.of(context).colorScheme;

    return AlertDialog(
      title: Text(loc.linkNotes, style: typo.titleMedium),
      content: SizedBox(
        width: double.maxFinite,
        child: ChangeNotifierProvider.value(
          value: editor,
          child: Consumer<NoteEditorProvider>(
            builder: (_, provider, __) {
              return ListView.builder(
                itemCount: allNotes.length,
                itemBuilder: (_, i) {
                  final n = allNotes[i];
                  final selected = provider.linkedNotes.contains(n.id);

                  return CheckboxListTile(
                    value: selected,
                    activeColor: color.primary,
                    title: Text(
                      n.title.isEmpty ? loc.noTitle : n.title,
                      style: typo.bodyMedium,
                    ),
                    onChanged: (_) => provider.toggleLinkedNote(n.id),
                    contentPadding: EdgeInsets.zero,
                  );
                },
              );
            },
          ),
        ),
      ),
      actionsPadding: EdgeInsets.symmetric(
        horizontal: spacing.sm,
        vertical: spacing.xs,
      ),
      actions: [
        Padding(
          padding: EdgeInsets.all(spacing.md),
          child: DSButton(
            label: loc.close,
            onPressed: () {
              context.pop();
            },
          ),
        ),
      ],
    );
  }
}
