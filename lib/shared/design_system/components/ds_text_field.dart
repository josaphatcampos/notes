import 'package:flutter/material.dart';

import '../theme/ds_sizes.dart';
import '../theme/ds_spacing.dart';
import '../theme/ds_typography.dart';

class DSTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final ValueChanged<String>? onChanged;
  final bool multiline;
  final TextInputType? keyboardType;
  final int? maxLines;

  const DSTextField({
    super.key,
    required this.controller,
    required this.label,
    this.onChanged,
    this.multiline = false,
    this.keyboardType,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).extension<DSSpacing>()!;
    final typo = Theme.of(context).extension<DSTypography>()!;

    return TextField(
      controller: controller
        ..selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length),
        ),
      onChanged: onChanged,
      keyboardType:
          keyboardType ??
          (multiline ? TextInputType.multiline : TextInputType.text),
      maxLines: multiline ? null : maxLines ?? 1,
      expands: multiline,
      textAlignVertical: TextAlignVertical.top,
      style: typo.bodyLarge,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: typo.bodyMedium,
        border: const OutlineInputBorder(),
        contentPadding: EdgeInsets.all(spacing.sm),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DSSizes.borderRadiusSmall),
          borderSide: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
    );
  }
}
