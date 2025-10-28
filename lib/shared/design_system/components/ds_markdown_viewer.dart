import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';

import '../theme/ds_spacing.dart';

class DSMarkdownViewer extends StatelessWidget {
  final String data;

  const DSMarkdownViewer({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).extension<DSSpacing>()!;
    return Padding(
      padding: EdgeInsets.all(spacing.md),
      child: MarkdownWidget(
        data: data,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
      ),
    );
  }
}
