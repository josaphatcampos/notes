import 'package:flutter/material.dart';

import '../theme/ds_colors.dart';
import '../theme/ds_spacing.dart';

enum DSIconButtonType { primary, secondary, danger, surface }

class DSIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final DSIconButtonType type;
  final String? tooltip;
  final double size;
  final EdgeInsets? padding;
  final bool filled;

  const DSIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.type = DSIconButtonType.surface,
    this.tooltip,
    this.size = 20,
    this.padding,
    this.filled = false,
  });

  Color _getBackgroundColor(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    switch (type) {
      case DSIconButtonType.primary:
        return filled ? color.primary : color.surfaceVariant;
      case DSIconButtonType.secondary:
        return filled ? color.secondary : color.surfaceVariant;
      case DSIconButtonType.danger:
        return filled ? DSColors.pink : color.surfaceVariant;
      case DSIconButtonType.surface:
      default:
        return filled ? color.surfaceVariant : Colors.transparent;
    }
  }

  Color _getForegroundColor(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    switch (type) {
      case DSIconButtonType.primary:
        return filled ? color.onPrimary : color.primary;
      case DSIconButtonType.secondary:
        return filled ? color.onSecondary : color.secondary;
      case DSIconButtonType.danger:
        return filled ? DSColors.white : DSColors.pink;
      case DSIconButtonType.surface:
      default:
        return color.onSurfaceVariant;
    }
  }

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).extension<DSSpacing>()!;

    final iconButton = IconButton(
      icon: Icon(icon, size: size),
      onPressed: onPressed,
      style: IconButton.styleFrom(
        backgroundColor: _getBackgroundColor(context),
        foregroundColor: _getForegroundColor(context),
        shape: const CircleBorder(),
        padding: padding ?? EdgeInsets.all(spacing.xs),
      ),
      tooltip: tooltip,
    );

    return tooltip != null
        ? Tooltip(message: tooltip!, child: iconButton)
        : iconButton;
  }
}
