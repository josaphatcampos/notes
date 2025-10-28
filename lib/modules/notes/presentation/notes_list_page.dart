import 'package:cocus/core/config/app_router.dart';
import 'package:cocus/l10n/app_localizations.dart';
import 'package:cocus/modules/notes/domain/entities/note.dart';
import 'package:cocus/modules/notes/presentation/components/filter.dart';
import 'package:cocus/modules/notes/presentation/providers/notes_provider.dart';
import 'package:cocus/modules/notes/presentation/widgets/note_card.dart';
import 'package:cocus/modules/notes/presentation/widgets/notes_search_delegate.dart';
import 'package:cocus/shared/design_system/components/ds_button.dart';
import 'package:cocus/shared/design_system/components/ds_dropdown_locale.dart';
import 'package:cocus/shared/design_system/components/ds_icon_button.dart';
import 'package:cocus/shared/design_system/widgets/confirm_delete_dialog.dart';
import 'package:cocus/shared/design_system/widgets/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../shared/design_system/theme/ds_colors.dart';
import '../../../shared/design_system/theme/ds_spacing.dart';
import '../../../shared/design_system/theme/ds_typography.dart';

class NotesListPage extends StatelessWidget {
  const NotesListPage({super.key});

  void _showDeleteConfirmationDialog(BuildContext context, Note note) {
    final provider = context.read<NotesProvider>();

    showDialog(
      context: context,
      builder: (dialogContext) => ConfirmDeleteDialog(
        noteTitle: note.title,
        onConfirm: () {
          provider.delete(note.id);
          Navigator.pop(dialogContext);
        },
      ),
    );
  }

  void _navigateToEdit(BuildContext context, {Note? note}) {
    if (note == null) {
      context.pushNamed(AppRoutes.newNoteName);
    } else {
      context.pushNamed(AppRoutes.editNoteName, extra: note);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final provider = context.watch<NotesProvider>();
    final notes = provider.notes;
    final spacing = Theme.of(context).extension<DSSpacing>()!;
    final typo = Theme.of(context).extension<DSTypography>()!;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isLargeScreen = constraints.maxWidth >= 600;

        return Scaffold(
          appBar: AppBar(
            title: Text(loc.notesTitle, style: typo.titleLarge),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: spacing.md),
                child: DSDropdownLocale(),
              ),
              if (isLargeScreen)
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: spacing.sm,
                    vertical: spacing.sm,
                  ),
                  child: DSButton(
                    onPressed: () => _navigateToEdit(context),
                    icon: Icons.add,
                    label: loc.newNote,
                  ),
                ),
              DSIconButton(
                icon: Icons.search,
                tooltip: loc.search,
                onPressed: () => showSearch(
                  context: context,
                  delegate: NotesSearchDelegate(provider),
                ),
              ),

              FilterNotes(),
            ],
          ),
          body: notes.isEmpty
              ? EmptyState(message: loc.emptyNotes)
              : (isLargeScreen
                    ? GridView.builder(
                        padding: EdgeInsets.all(spacing.md),
                        itemCount: notes.length,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 350,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                              childAspectRatio: 1.2,
                            ),
                        itemBuilder: (_, i) {
                          final note = notes[i];
                          return NoteCard(
                            note: note,
                            isGrid: true,
                            onDelete: () =>
                                _showDeleteConfirmationDialog(context, note),
                          );
                        },
                      )
                    : ListView.builder(
                        padding: EdgeInsets.all(spacing.md),
                        itemCount: notes.length,
                        itemBuilder: (_, i) {
                          final note = notes[i];
                          return Padding(
                            padding: EdgeInsets.only(bottom: spacing.md),
                            child: NoteCard(
                              note: note,
                              isGrid: false,
                              onLongPress: () =>
                                  _showDeleteConfirmationDialog(context, note),
                            ),
                          );
                        },
                      )),
          floatingActionButton: isLargeScreen
              ? null
              : FloatingActionButton(
                  onPressed: () => _navigateToEdit(context),
                  tooltip: loc.newNote,
                  backgroundColor: DSColors.orange,
                  child: const Icon(Icons.add),
                ),
        );
      },
    );
  }
}
