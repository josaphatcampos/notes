import 'package:cocus/core/config/app_router.dart';
import 'package:cocus/l10n/app_localizations.dart';
import 'package:cocus/modules/notes/presentation/providers/note_editor_provider.dart';
import 'package:cocus/modules/notes/presentation/providers/notes_provider.dart';
import 'package:cocus/modules/notes/presentation/widgets/note_attachment_list.dart';
import 'package:cocus/modules/notes/presentation/widgets/note_link_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../shared/design_system/components/ds_button.dart';
import '../../../shared/design_system/components/ds_chip.dart';
import '../../../shared/design_system/components/ds_icon_button.dart';
import '../../../shared/design_system/components/ds_text_field.dart';
import '../../../shared/design_system/theme/ds_spacing.dart';
import '../../../shared/design_system/theme/ds_typography.dart';
import '../domain/entities/note.dart';

class NoteEditPage extends StatelessWidget {
  final Note? note;

  const NoteEditPage({super.key, this.note});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final typo = Theme.of(context).extension<DSTypography>()!;
    final spacing = Theme.of(context).extension<DSSpacing>()!;
    final color = Theme.of(context).colorScheme;

    return ChangeNotifierProvider(
      create: (_) =>
          NoteEditorProvider(context.read<NotesProvider>())..startEditing(note),
      builder: (context, _) {
        final editor = context.watch<NoteEditorProvider>();
        final allNotes = context
            .read<NotesProvider>()
            .notes
            .where((n) => n.id != note?.id)
            .toList();

        return Scaffold(
          appBar: AppBar(
            title: Text(
              note == null ? loc.newNote : loc.editNote,
              style: typo.titleLarge.copyWith(color: color.onPrimary),
            ),
            actions: [
              DSIconButton(
                icon: Icons.save,
                tooltip: loc.save,
                onPressed: () async {
                  await editor.save();
                  if (context.mounted) {
                    context.goNamed(AppRoutes.notesListName);
                  }
                },
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.all(spacing.md),
            child: Column(
              children: [
                DSTextField(
                  label: loc.title,
                  onChanged: editor.updateTitle,
                  controller: TextEditingController(text: editor.title),
                ),
                SizedBox(height: spacing.md),

                Expanded(
                  child: DSTextField(
                    label: loc.markdownHint,
                    onChanged: editor.updateContent,
                    multiline: true,
                    controller: TextEditingController(text: editor.content),
                  ),
                ),
                SizedBox(height: spacing.md),

                Wrap(
                  spacing: spacing.sm,
                  children: [
                    DSButton(
                      icon: Icons.image,
                      label: loc.addImage,
                      onPressed: editor.addImage,
                    ),
                    DSButton(
                      icon: Icons.link,
                      label: loc.linkNotes,
                      onPressed: () => showDialog(
                        context: context,
                        builder: (_) =>
                            NoteLinkDialog(allNotes: allNotes, editor: editor),
                      ),
                      type: DSButtonType.secondary,
                    ),
                  ],
                ),
                SizedBox(height: spacing.md),

                if (editor.attachments.isNotEmpty)
                  NoteAttachmentList(
                    attachments: editor.attachments,
                    onRemove: editor.removeImage,
                  ),
                SizedBox(height: spacing.md),

                if (editor.linkedNotes.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(loc.linkedNotes, style: typo.titleMedium),
                      SizedBox(height: spacing.sm),
                      Wrap(
                        spacing: spacing.sm,
                        runSpacing: spacing.xs,
                        children: editor.linkedNotes.map((id) {
                          return DSChip(
                            label: '${loc.linkNotes}: $id',
                            onDeleted: () => editor.toggleLinkedNote(id),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
