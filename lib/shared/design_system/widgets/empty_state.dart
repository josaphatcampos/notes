import 'package:cocus/shared/design_system/theme/ds_spacing.dart';
import 'package:cocus/shared/design_system/theme/ds_typography.dart';
import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final String message;
  final IconData icon;

  const EmptyState({
    super.key,
    required this.message,
    this.icon = Icons.note_add_outlined,
  });

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).extension<DSSpacing>()!;
    final typo = Theme.of(context).extension<DSTypography>()!;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(spacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 64, color: Theme.of(context).colorScheme.outline),
            SizedBox(height: spacing.md),
            Text(
              message,
              style: typo.bodyLarge.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
