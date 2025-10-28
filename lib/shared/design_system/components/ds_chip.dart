import 'package:flutter/material.dart';

import '../theme/ds_colors.dart';
import '../theme/ds_spacing.dart';
import '../theme/ds_typography.dart';

class DSChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onDeleted;
  final VoidCallback? onPressed;
  final Color? background;

  const DSChip({
    super.key,
    required this.label,
    this.icon,
    this.onDeleted,
    this.background,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).extension<DSSpacing>()!;
    final typo = Theme.of(context).extension<DSTypography>()!;
    final color = Theme.of(context).colorScheme;

    return (onPressed != null)
        ? ActionChip(
            avatar: icon != null
                ? Icon(icon, size: 16, color: color.primary)
                : null,
            label: Text(label, style: typo.caption),
            onPressed: onPressed,
            backgroundColor:
                background ?? color.surfaceVariant.withOpacity(0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(spacing.sm),
            ),
            visualDensity: VisualDensity.compact,
          )
        : Chip(
            avatar: icon != null
                ? Icon(icon, size: 16, color: color.primary)
                : null,
            label: Text(label, style: typo.caption),
            deleteIcon: onDeleted != null
                ? const Icon(Icons.close, size: 16, color: DSColors.gray)
                : null,
            onDeleted: onDeleted,
            backgroundColor:
                background ?? color.surfaceVariant.withOpacity(0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(spacing.sm),
            ),
            visualDensity: VisualDensity.compact,
          );
  }
}
