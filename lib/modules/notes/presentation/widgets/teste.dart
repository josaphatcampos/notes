// import 'dart:convert';
//
// import 'package:cocus/core/config/app_router.dart';
// import 'package:cocus/l10n/app_localizations.dart';
// import 'package:cocus/modules/notes/domain/entities/note.dart';
// import 'package:cocus/modules/notes/presentation/components/error_image.dart';
// import 'package:cocus/modules/notes/presentation/helpers/attachment_image_widget.dart';
// import 'package:cocus/modules/notes/presentation/providers/notes_provider.dart';
// import 'package:cocus/shared/utils/note_pdf_exporter.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:markdown_widget/markdown_widget.dart';
// import 'package:provider/provider.dart';
//
// import '../../../shared/design_system/theme/ds_colors.dart';
// import '../../../shared/design_system/theme/ds_sizes.dart';
// import '../../../shared/design_system/theme/ds_spacing.dart';
// import '../../../shared/design_system/theme/ds_typography.dart';
//
// class NoteDetailPage extends StatelessWidget {
//   final String noteId;
//
//   const NoteDetailPage({super.key, required this.noteId});
//
//   @override
//   Widget build(BuildContext context) {
//     final loc = AppLocalizations.of(context)!;
//     final provider = context.watch<NotesProvider>();
//     final note = provider.getById(noteId);
//
//     final typo = Theme.of(context).extension<DSTypography>()!;
//     final spacing = Theme.of(context).extension<DSSpacing>()!;
//     final color = Theme.of(context).colorScheme;
//
//     if (note == null) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         if (context.canPop()) context.pop();
//       });
//       return Scaffold(
//         body: Center(child: Text(loc.noteNotFound, style: typo.bodyLarge)),
//       );
//     }
//
//     final linkedNotes = provider.getNotesByIds(note.linkedNoteIds);
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final bool isLargeScreen = constraints.maxWidth >= 600;
//
//         return Scaffold(
//           appBar: AppBar(
//             leading: isLargeScreen
//                 ? Center(
//                     child: TextButton.icon(
//                       icon: const Icon(Icons.arrow_back_ios_new, size: 16),
//                       label: Text(
//                         loc.backToList,
//                         style: typo.bodyMedium.copyWith(color: DSColors.white),
//                       ),
//                       onPressed: () => context.goNamed(AppRoutes.notesListName),
//                       style: TextButton.styleFrom(
//                         foregroundColor: color.onPrimary,
//                         padding: EdgeInsets.symmetric(horizontal: spacing.sm),
//                       ),
//                     ),
//                   )
//                 : null,
//             leadingWidth: isLargeScreen ? 120 : null,
//             title: Text(
//               note.title.isEmpty ? loc.noTitle : note.title,
//               style: typo.titleLarge.copyWith(color: color.onPrimary),
//               overflow: TextOverflow.ellipsis,
//             ),
//             actions: _buildAppBarActions(context, note, provider, loc),
//           ),
//           body: SafeArea(
//             child: ListView(
//               padding: EdgeInsets.fromLTRB(
//                 spacing.md,
//                 spacing.md,
//                 spacing.md,
//                 spacing.xl * 2,
//               ),
//               children: [
//                 MarkdownWidget(
//                   data: note.content,
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                 ),
//
//                 if (linkedNotes.isNotEmpty) ...[
//                   SizedBox(height: spacing.lg),
//                   Divider(color: color.outlineVariant),
//                   SizedBox(height: spacing.sm),
//                   Text(
//                     loc.linkedNotes,
//                     style: typo.titleMedium.copyWith(color: color.outline),
//                   ),
//                   SizedBox(height: spacing.sm),
//                   Wrap(
//                     spacing: spacing.sm,
//                     runSpacing: spacing.xs,
//                     children: linkedNotes.map((linkedNote) {
//                       return ActionChip(
//                         avatar: Icon(
//                           Icons.link,
//                           size: 16,
//                           color: color.primary,
//                         ),
//                         label: Text(
//                           linkedNote.title.isNotEmpty
//                               ? linkedNote.title
//                               : loc.noTitle,
//                           style: typo.bodyMedium,
//                         ),
//                         tooltip: loc.goToNote(
//                           linkedNote.title.isEmpty
//                               ? loc.noTitle
//                               : linkedNote.title,
//                         ),
//                         backgroundColor: color.surfaceVariant.withOpacity(0.1),
//                         onPressed: () => context.pushNamed(
//                           AppRoutes.noteDetailName,
//                           pathParameters: {'id': linkedNote.id},
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 ],
//
//                 if (note.attachments.isNotEmpty) ...[
//                   SizedBox(height: spacing.lg),
//                   Divider(color: color.outlineVariant),
//                   SizedBox(height: spacing.sm),
//                   Text(
//                     loc.attachments,
//                     style: typo.titleMedium.copyWith(color: color.outline),
//                   ),
//                   SizedBox(height: spacing.sm),
//                   Wrap(
//                     spacing: spacing.sm,
//                     runSpacing: spacing.sm,
//                     children: note.attachments.map((img) {
//                       Widget imageThumbnail;
//                       if (img.isBase64) {
//                         try {
//                           final bytes = base64Decode(img.url.split(',').last);
//                           imageThumbnail = Image.memory(
//                             bytes,
//                             width: DSSizes.thumbLarge,
//                             height: DSSizes.thumbLarge,
//                             fit: BoxFit.cover,
//                           );
//                         } catch (_) {
//                           imageThumbnail = const ErrorImage();
//                         }
//                       } else {
//                         imageThumbnail = AttachmentImageWidget(
//                           url: img.url,
//                           width: DSSizes.thumbLarge,
//                           height: DSSizes.thumbLarge,
//                           borderRadius: BorderRadius.circular(
//                             DSSizes.borderRadiusMedium,
//                           ),
//                         );
//                       }
//                       return GestureDetector(
//                         onTap: () => _showEnlargedImage(context, img),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(
//                             DSSizes.borderRadiusMedium,
//                           ),
//                           child: imageThumbnail,
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 ],
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   List<Widget> _buildAppBarActions(
//     BuildContext context,
//     Note note,
//     NotesProvider provider,
//     AppLocalizations loc,
//   ) {
//     final typo = Theme.of(context).extension<DSTypography>()!;
//     final spacing = Theme.of(context).extension<DSSpacing>()!;
//     final color = Theme.of(context).colorScheme;
//
//     return [
//       IconButton(
//         icon: const Icon(Icons.picture_as_pdf),
//         tooltip: loc.exportPDF,
//         onPressed: () => NotePdfExporter.export(note),
//       ),
//       IconButton(
//         icon: const Icon(Icons.edit),
//         tooltip: loc.editNote,
//         onPressed: () => context.pushNamed(AppRoutes.editNoteName, extra: note),
//       ),
//       IconButton(
//         icon: const Icon(Icons.delete),
//         tooltip: loc.delete,
//         onPressed: () =>
//             _showDeleteConfirmationDialog(context, note, provider, loc),
//       ),
//       SizedBox(width: spacing.sm),
//     ];
//   }
//
//   void _showDeleteConfirmationDialog(
//     BuildContext context,
//     Note note,
//     NotesProvider provider,
//     AppLocalizations loc,
//   ) {
//     final typo = Theme.of(context).extension<DSTypography>()!;
//     final spacing = Theme.of(context).extension<DSSpacing>()!;
//
//     showDialog(
//       context: context,
//       builder: (dialogContext) => AlertDialog(
//         title: Text(loc.deleteNoteQuestion, style: typo.titleMedium),
//         content: Padding(
//           padding: EdgeInsets.only(top: spacing.sm),
//           child: Text(loc.deleteNoteWarning, style: typo.bodyMedium),
//         ),
//         actions: [
//           TextButton(
//             child: Text(loc.cancel, style: typo.bodyMedium),
//             onPressed: () => context.pop(),
//           ),
//           TextButton(
//             style: TextButton.styleFrom(foregroundColor: DSColors.pink),
//             child: Text(loc.delete, style: typo.bodyMedium),
//             onPressed: () {
//               provider.delete(note.id);
//               context.pop();
//               context.goNamed(AppRoutes.notesListName);
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showEnlargedImage(BuildContext context, dynamic img) {
//     final spacing = Theme.of(context).extension<DSSpacing>()!;
//     showDialog(
//       context: context,
//       builder: (dialogContext) {
//         return Dialog(
//           backgroundColor: Colors.transparent,
//           insetPadding: EdgeInsets.all(spacing.md),
//           child: InteractiveViewer(
//             boundaryMargin: EdgeInsets.all(spacing.sm),
//             minScale: 0.5,
//             maxScale: 4.0,
//             child: _buildEnlargedImage(img),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildEnlargedImage(dynamic img) {
//     if (img.isBase64) {
//       try {
//         final bytes = base64Decode(img.url.split(',').last);
//         return Image.memory(bytes, fit: BoxFit.contain);
//       } catch (_) {
//         return const Center(
//           child: Icon(Icons.broken_image, color: Colors.white, size: 80),
//         );
//       }
//     } else {
//       return AttachmentImageWidget(
//         url: img.url,
//         borderRadius: BorderRadius.circular(DSSizes.borderRadiusMedium),
//       );
//     }
//   }
// }
