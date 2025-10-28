import 'package:cocus/modules/notes/domain/entities/note_attachment.dart';
import 'package:cocus/shared/design_system/components/ds_image_preview.dart';
import 'package:cocus/shared/design_system/theme/ds_spacing.dart';
import 'package:flutter/material.dart';

import '../../../../shared/design_system/theme/ds_sizes.dart';

class NoteAttachmentList extends StatelessWidget {
  final List<NoteAttachment> attachments;
  final ValueChanged<String>? onRemove;

  const NoteAttachmentList({
    super.key,
    required this.attachments,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).extension<DSSpacing>()!;
    return SizedBox(
      height: DSSizes.thumbSmall + spacing.sm,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: attachments.length,
        separatorBuilder: (_, __) => SizedBox(width: spacing.sm),
        itemBuilder: (_, i) {
          final att = attachments[i];
          return DSImagePreview(
            imageUrl: att.url,
            onRemove: onRemove != null ? () => onRemove!(att.id) : null,
          );
        },
      ),
    );
  }
}
