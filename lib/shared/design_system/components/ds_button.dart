import 'package:flutter/material.dart';

import '../theme/ds_colors.dart';
import '../theme/ds_sizes.dart';
import '../theme/ds_spacing.dart';
import '../theme/ds_typography.dart';

enum DSButtonType { primary, secondary, danger }

class DSButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final DSButtonType type;
  final bool fullWidth;

  const DSButton({
    super.key,
    required this.label,
    this.icon,
    this.onPressed,
    this.type = DSButtonType.primary,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final spacing = Theme.of(context).extension<DSSpacing>()!;
    final typo = Theme.of(context).extension<DSTypography>()!;

    Color bg;
    Color fg;

    switch (type) {
      case DSButtonType.secondary:
        bg = color.secondary;
        fg = color.onSecondary;
        break;
      case DSButtonType.danger:
        bg = DSColors.pink;
        fg = DSColors.white;
        break;
      default:
        bg = color.primary;
        fg = DSColors.white;
    }
 
    final button = ElevatedButton.icon(
      icon: icon != null ? Icon(icon, size: 18) : const SizedBox.shrink(),
      label: Text(label, style: typo.bodyMedium.copyWith(color: fg)),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: bg,
        foregroundColor: fg,
        minimumSize: fullWidth ? const Size.fromHeight(48) : null,
        padding: EdgeInsets.symmetric(
          horizontal: spacing.md,
          vertical: spacing.sm,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DSSizes.borderRadiusSmall),
        ),
      ),
    );

    return fullWidth ? SizedBox(width: double.infinity, child: button) : button;
  }
}
