import 'package:flutter/material.dart';

import '../theme/ds_spacing.dart';
import '../theme/ds_typography.dart';
import 'ds_button.dart';

class DSDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final DSButtonType confirmType;

  const DSDialog({
    super.key,
    required this.title,
    required this.message,
    required this.confirmLabel,
    required this.cancelLabel,
    required this.onConfirm,
    this.onCancel,
    this.confirmType = DSButtonType.primary,
  });

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).extension<DSSpacing>()!;
    final typo = Theme.of(context).extension<DSTypography>()!;

    return AlertDialog(
      title: Text(title, style: typo.titleMedium),
      content: Padding(
        padding: EdgeInsets.only(top: spacing.sm),
        child: Text(message, style: typo.bodyMedium),
      ),
      actions: [
        TextButton(
          onPressed: onCancel ?? () => Navigator.pop(context),
          child: Text(cancelLabel, style: typo.bodyMedium),
        ),
        DSButton(label: confirmLabel, onPressed: onConfirm, type: confirmType),
      ],
    );
  }
}
