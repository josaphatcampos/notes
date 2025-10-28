import 'package:flutter/material.dart';

import '../../../../shared/design_system/theme/ds_sizes.dart';

class ErrorImage extends StatelessWidget {
  final double width;
  final double height;

  const ErrorImage({
    this.width = DSSizes.thumbLarge,
    this.height = DSSizes.thumbLarge,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Container(
    color: Colors.grey.shade300,
    width: width,
    height: height,
    alignment: Alignment.center,
    child: const Icon(Icons.broken_image, color: Colors.grey),
  );
}
