import 'dart:convert';

import 'package:cocus/core/config/app_router.dart';
import 'package:cocus/l10n/app_localizations.dart';
import 'package:cocus/modules/notes/domain/entities/note.dart';
import 'package:cocus/modules/notes/presentation/components/error_image.dart';
import 'package:cocus/modules/notes/presentation/providers/notes_provider.dart';
import 'package:cocus/modules/notes/presentation/widgets/enlarged_image.dart';
import 'package:cocus/shared/design_system/theme/ds_colors.dart';
import 'package:cocus/shared/utils/note_pdf_exporter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../shared/design_system/components/ds_button.dart';
import '../../../shared/design_system/components/ds_chip.dart';
import '../../../shared/design_system/components/ds_icon_button.dart';
import '../../../shared/design_system/components/ds_image_preview.dart';
import '../../../shared/design_system/components/ds_markdown_viewer.dart';
import '../../../shared/design_system/theme/ds_sizes.dart';
import '../../../shared/design_system/theme/ds_spacing.dart';
import '../../../shared/design_system/theme/ds_typography.dart';
import '../../../shared/design_system/widgets/confirm_delete_dialog.dart';

class NoteDetailPage extends StatelessWidget {
  final String noteId;

  const NoteDetailPage({super.key, required this.noteId});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final provider = context.watch<NotesProvider>();
    final note = provider.getById(noteId);

    final typo = Theme.of(context).extension<DSTypography>()!;
    final spacing = Theme.of(context).extension<DSSpacing>()!;
    final color = Theme.of(context).colorScheme;

    if (note == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.canPop()) context.pop();
      });
      return Scaffold(
        body: Center(child: Text(loc.noteNotFound, style: typo.bodyLarge)),
      );
    }

    final linkedNotes = provider.getNotesByIds(note.linkedNoteIds);

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isLargeScreen = constraints.maxWidth >= 600;

        return Scaffold(
          appBar: AppBar(
            leading: isLargeScreen
                ? Padding(
                    padding: EdgeInsets.only(left: spacing.sm),
                    child: DSButton(
                      icon: Icons.home,
                      label: loc.backToList,
                      onPressed: () => context.goNamed(AppRoutes.notesListName),
                    ),
                  )
                : null,
            leadingWidth: isLargeScreen ? 160 : null,
            title: Text(
              note.title.isEmpty ? loc.noTitle : note.title,
              style: typo.titleLarge.copyWith(color: DSColors.white),
              overflow: TextOverflow.ellipsis,
            ),
            actions: [
              DSIconButton(
                icon: Icons.picture_as_pdf,
                tooltip: loc.exportPDF,
                onPressed: () => NotePdfExporter.export(context, note),
              ),
              DSIconButton(
                icon: Icons.edit,
                tooltip: loc.editNote,
                onPressed: () =>
                    context.pushNamed(AppRoutes.editNoteName, extra: note),
              ),
              DSIconButton(
                icon: Icons.delete,
                tooltip: loc.delete,
                type: DSIconButtonType.danger,
                onPressed: () =>
                    _showDeleteConfirmationDialog(context, note, provider, loc),
              ),
              SizedBox(width: spacing.sm),
            ],
          ),
          body: SafeArea(
            child: ListView(
              padding: EdgeInsets.fromLTRB(
                spacing.md,
                spacing.md,
                spacing.md,
                spacing.xl * 2,
              ),
              children: [
                DSMarkdownViewer(data: note.content),

                if (linkedNotes.isNotEmpty) ...[
                  SizedBox(height: spacing.lg),
                  Divider(color: color.outlineVariant),
                  SizedBox(height: spacing.sm),
                  Text(
                    loc.linkedNotes,
                    style: typo.titleMedium.copyWith(color: color.outline),
                  ),
                  SizedBox(height: spacing.sm),
                  Wrap(
                    spacing: spacing.sm,
                    runSpacing: spacing.xs,
                    children: linkedNotes.map((linkedNote) {
                      return DSChip(
                        label: linkedNote.title.isNotEmpty
                            ? linkedNote.title
                            : loc.noTitle,
                        icon: Icons.link,
                        onPressed: () => context.pushNamed(
                          AppRoutes.noteDetailName,
                          pathParameters: {'id': linkedNote.id},
                        ),
                      );
                    }).toList(),
                  ),
                ],

                if (note.attachments.isNotEmpty) ...[
                  SizedBox(height: spacing.lg),
                  Divider(color: color.outlineVariant),
                  SizedBox(height: spacing.sm),
                  Text(
                    loc.attachments,
                    style: typo.titleMedium.copyWith(color: color.outline),
                  ),
                  SizedBox(height: spacing.sm),
                  Wrap(
                    spacing: spacing.sm,
                    runSpacing: spacing.sm,
                    children: note.attachments.map((img) {
                      Widget imageWidget;
                      if (img.isBase64) {
                        try {
                          final bytes = base64Decode(img.url.split(',').last);
                          imageWidget = Image.memory(
                            bytes,
                            width: DSSizes.thumbLarge,
                            height: DSSizes.thumbLarge,
                            fit: BoxFit.cover,
                          );
                        } catch (_) {
                          imageWidget = const ErrorImage();
                        }
                      } else {
                        imageWidget = DSImagePreview(
                          imageUrl: img.url,
                          size: DSSizes.thumbLarge,
                        );
                      }

                      return GestureDetector(
                        onTap: () => _showEnlargedImage(context, img),
                        child: imageWidget,
                      );
                    }).toList(),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(
    BuildContext context,
    Note note,
    NotesProvider provider,
    AppLocalizations loc,
  ) {
    showDialog(
      context: context,
      builder: (_) => ConfirmDeleteDialog(
        noteTitle: loc.deleteNoteQuestion,
        description: loc.deleteNoteWarning,
        onConfirm: () {
          provider.delete(note.id);
          context.pop();
          context.goNamed(AppRoutes.notesListName);
        },
      ),
    );
  }

  void _showEnlargedImage(BuildContext context, dynamic img) {
    final spacing = Theme.of(context).extension<DSSpacing>()!;
    showDialog(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(spacing.md),
          child: InteractiveViewer(
            boundaryMargin: EdgeInsets.all(spacing.sm),
            minScale: 0.5,
            maxScale: 4.0,
            child: EnlargedImage(img: img),
          ),
        );
      },
    );
  }
}
