import 'dart:convert';

import 'package:cocus/core/config/app_router.dart';
import 'package:cocus/l10n/app_localizations.dart';
import 'package:cocus/modules/notes/domain/entities/note.dart';
import 'package:cocus/modules/notes/presentation/components/error_image.dart';
import 'package:cocus/modules/notes/presentation/helpers/attachment_image_widget.dart';
import 'package:cocus/shared/design_system/components/ds_chip.dart';
import 'package:cocus/shared/design_system/theme/ds_sizes.dart';
import 'package:cocus/shared/design_system/theme/ds_spacing.dart';
import 'package:cocus/shared/design_system/theme/ds_typography.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/design_system/theme/ds_colors.dart';

class NoteCard extends StatefulWidget {
  final Note note;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final VoidCallback? onDelete;
  final bool isGrid;

  const NoteCard({
    super.key,
    required this.note,
    this.onTap,
    this.onLongPress,
    this.onDelete,
    this.isGrid = false,
  });

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  bool _isHovering = false;

  static String _formatDate(BuildContext context, DateTime date) {
    final loc = AppLocalizations.of(context)!;
    final formatted =
        '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year} '
        '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    return loc.lastUpdated(formatted);
  }

  @override
  Widget build(BuildContext context) {
    final typo = Theme.of(context).extension<DSTypography>()!;
    final spacing = Theme.of(context).extension<DSSpacing>()!;
    final loc = AppLocalizations.of(context)!;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DSSizes.borderRadiusMedium),
      ),
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      child: InkWell(
        onTap:
            widget.onTap ??
            () => context.pushNamed(
              AppRoutes.noteDetailName,
              pathParameters: {'id': widget.note.id},
            ),
        onLongPress: widget.onLongPress,
        onHover: (hovering) {
          if (widget.isGrid) setState(() => _isHovering = hovering);
        },
        child: Padding(
          padding: EdgeInsets.all(spacing.md),
          child: Stack(
            children: [
              if (widget.isGrid && _isHovering)
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.red.withOpacity(0.8),
                      shape: const CircleBorder(),
                    ),
                    icon: const Icon(
                      Icons.delete_forever,
                      color: DSColors.white,
                      size: 20,
                    ),
                    tooltip: loc.delete,
                    onPressed: widget.onDelete,
                  ),
                ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.note.title.isEmpty ? loc.noTitle : widget.note.title,
                    style: typo.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: spacing.xs),

                  if (widget.isGrid)
                    Expanded(
                      child: Text(
                        widget.note.preview,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: typo.bodyMedium,
                      ),
                    )
                  else
                    Padding(
                      padding: EdgeInsets.only(bottom: spacing.xs),
                      child: Text(
                        widget.note.preview,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: typo.bodyMedium,
                      ),
                    ),

                  SizedBox(height: spacing.sm),

                  if (widget.note.attachments.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(bottom: spacing.sm),
                      child: SizedBox(
                        height: DSSizes.thumbSmall,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.note.attachments.length > 3
                              ? 3
                              : widget.note.attachments.length,
                          separatorBuilder: (_, __) =>
                              SizedBox(width: spacing.sm),
                          itemBuilder: (_, index) {
                            final img = widget.note.attachments[index];
                            if (img.isBase64) {
                              try {
                                final bytes = base64Decode(
                                  img.url.split(',').last,
                                );
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    DSSizes.borderRadiusSmall,
                                  ),
                                  child: Image.memory(
                                    bytes,
                                    width: DSSizes.thumbSmall,
                                    height: DSSizes.thumbSmall,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              } catch (_) {
                                return const ErrorImage();
                              }
                            } else {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  DSSizes.borderRadiusSmall,
                                ),
                                child: AttachmentImageWidget(
                                  url: img.url,
                                  width: DSSizes.thumbSmall,
                                  height: DSSizes.thumbSmall,
                                  borderRadius: BorderRadius.circular(
                                    DSSizes.borderRadiusSmall,
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),

                  Wrap(
                    spacing: spacing.sm,
                    runSpacing: spacing.xs,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      if (widget.note.linkedNoteIds.isNotEmpty)
                        DSChip(
                          icon: Icons.link,
                          label:
                              '${widget.note.linkedNoteIds.length} link${widget.note.linkedNoteIds.length > 1 ? 's' : ''}',
                        ),
                      Text(
                        _formatDate(context, widget.note.updatedAt),
                        style: typo.caption,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
