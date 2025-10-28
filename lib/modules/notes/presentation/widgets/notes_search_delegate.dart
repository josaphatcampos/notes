import 'package:cocus/core/config/app_router.dart';
import 'package:cocus/l10n/app_localizations.dart';
import 'package:cocus/modules/notes/presentation/providers/notes_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/design_system/theme/ds_typography.dart';

class NotesSearchDelegate extends SearchDelegate {
  final NotesProvider provider;

  NotesSearchDelegate(this.provider);

  @override
  List<Widget>? buildActions(BuildContext context) => [
    IconButton(icon: const Icon(Icons.clear), onPressed: () => query = ''),
  ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () => close(context, null),
  );

  @override
  Widget buildResults(BuildContext context) {
    final results = provider.search(query);
    final typo = Theme.of(context).extension<DSTypography>()!;
    final loc = AppLocalizations.of(context)!;

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (_, i) {
        final note = results[i];
        return ListTile(
          title: Text(
            note.title.isEmpty ? loc.noTitle : note.title,
            style: typo.bodyLarge,
          ),
          subtitle: Text(note.preview, style: typo.bodyMedium),
          onTap: () {
            close(context, null);
            context.pushNamed(
              AppRoutes.noteDetailName,
              pathParameters: {'id': note.id},
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) => buildResults(context);
}
