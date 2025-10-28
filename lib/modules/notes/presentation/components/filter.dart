import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../shared/design_system/theme/ds_typography.dart';
import '../providers/notes_provider.dart';

class FilterNotes extends StatelessWidget {
  const FilterNotes({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NotesProvider>();
    final loc = AppLocalizations.of(context)!;
    final typo = Theme.of(context).extension<DSTypography>()!;

    return PopupMenuButton<NoteSortType>(
      icon: const Icon(Icons.sort),
      tooltip: loc.sort,
      initialValue: provider.sortType,
      onSelected: provider.sortNotes,
      itemBuilder: (context) => [
        PopupMenuItem(
          value: NoteSortType.titleAsc,
          child: Text(loc.sortTitleAsc, style: typo.bodyMedium),
        ),
        PopupMenuItem(
          value: NoteSortType.titleDesc,
          child: Text(loc.sortTitleDesc, style: typo.bodyMedium),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          value: NoteSortType.createdAsc,
          child: Text(loc.sortCreatedAsc, style: typo.bodyMedium),
        ),
        PopupMenuItem(
          value: NoteSortType.createdDesc,
          child: Text(loc.sortCreatedDesc, style: typo.bodyMedium),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          value: NoteSortType.updatedAsc,
          child: Text(loc.sortUpdatedAsc, style: typo.bodyMedium),
        ),
        PopupMenuItem(
          value: NoteSortType.updatedDesc,
          child: Text(loc.sortUpdatedDesc, style: typo.bodyMedium),
        ),
      ],
    );
  }
}
