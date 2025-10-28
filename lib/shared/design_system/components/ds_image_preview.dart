import 'package:flutter/material.dart';

import '../../../modules/notes/presentation/helpers/attachment_Image_widget.dart';
import '../theme/ds_sizes.dart';

class DSImagePreview extends StatelessWidget {
  final String imageUrl;
  final double size;
  final VoidCallback? onRemove;

  const DSImagePreview({
    super.key,
    required this.imageUrl,
    this.size = DSSizes.thumbSmall,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(DSSizes.borderRadiusSmall),
          child: AttachmentImageWidget(
            url: imageUrl,
            width: size,
            height: size,
            fit: BoxFit.cover,
          ),
        ),
        if (onRemove != null)
          Positioned(
            right: 2,
            top: 2,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(
                    DSSizes.borderRadiusSmall,
                  ),
                ),
                child: const Icon(Icons.close, size: 14, color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }
}
