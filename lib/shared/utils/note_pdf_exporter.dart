import 'dart:convert';

import 'package:cocus/l10n/app_localizations.dart';
import 'package:cocus/modules/notes/domain/entities/note.dart';
import 'package:flutter/material.dart';
import 'package:htmltopdfwidgets/htmltopdfwidgets.dart' as html;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class NotePdfExporter {
  static Future<void> export(BuildContext context, Note note) async {
    final loc = AppLocalizations.of(context)!;
    final pdf = pw.Document();

    final font = await PdfGoogleFonts.robotoRegular();
    final bold = await PdfGoogleFonts.robotoBold();

    final markdownBlocks = note.content.split('\n\n');

    final markdownWidgets = <pw.Widget>[];
    for (final block in markdownBlocks) {
      final converted = await html.HTMLToPdf().convertMarkdown(block);
      if (converted != null && converted.isNotEmpty) {
        markdownWidgets.addAll(converted);
      }
    }

    pdf.addPage(
      pw.MultiPage(
        theme: pw.ThemeData.withFont(base: font, bold: bold),
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (context) => [
          pw.Header(
            level: 0,
            child: pw.Text(
              note.title.isEmpty ? '(${loc.noTitle})' : note.title,
              style: pw.TextStyle(font: bold, fontSize: 22),
            ),
          ),
          pw.Text(
            '${loc.updatedAtLabel}: ${note.updatedAt}',
            style: pw.TextStyle(
              font: font,
              fontSize: 10,
              color: PdfColors.grey,
            ),
          ),
          pw.SizedBox(height: 20),

          ...markdownWidgets,

          pw.SizedBox(height: 20),

          if (note.attachments.isNotEmpty)
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  loc.attachments,
                  style: pw.TextStyle(font: bold, fontSize: 14),
                ),
                pw.SizedBox(height: 8),
                pw.Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: note.attachments.map((img) {
                    try {
                      if (img.isBase64) {
                        final bytes = base64Decode(img.url.split(',').last);
                        final image = pw.MemoryImage(bytes);
                        return pw.Container(
                          width: 200,
                          height: 200,
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(color: PdfColors.grey300),
                            borderRadius: pw.BorderRadius.circular(8),
                          ),
                          child: pw.ClipRRect(
                            horizontalRadius: 8,
                            verticalRadius: 8,
                            child: pw.Image(image, fit: pw.BoxFit.cover),
                          ),
                        );
                      }
                    } catch (_) {}
                    return pw.Container();
                  }).toList(),
                ),
              ],
            ),
        ],
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }
}
