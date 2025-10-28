import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../shared/design_system/theme/ds_sizes.dart';
import '../helpers/attachment_Image_widget.dart';

class EnlargedImage extends StatelessWidget {
  const EnlargedImage({super.key, required this.img});

  final dynamic img;

  @override
  Widget build(BuildContext context) {
    if (img.isBase64) {
      try {
        final bytes = base64Decode(img.url.split(',').last);
        return Image.memory(bytes, fit: BoxFit.contain);
      } catch (_) {
        return const Center(
          child: Icon(Icons.broken_image, color: Colors.white, size: 80),
        );
      }
    } else {
      return AttachmentImageWidget(
        url: img.url,
        borderRadius: BorderRadius.circular(DSSizes.borderRadiusMedium),
      );
    }
  }
}
