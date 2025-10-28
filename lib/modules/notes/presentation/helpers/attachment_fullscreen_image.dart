import 'dart:convert';

import 'package:flutter/material.dart';

import '../components/error_image.dart';

class AttachmentFullscreenImage extends StatelessWidget {
  final String tag;
  final String url;

  const AttachmentFullscreenImage({
    super.key,
    required this.tag,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    final normalized = _normalizeUrl(url);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Hero(
          tag: tag,
          child: InteractiveViewer(
            panEnabled: true,
            minScale: 0.5,
            maxScale: 3.0,
            child: Center(child: _buildImage(normalized)),
          ),
        ),
      ),
    );
  }

  Widget _buildImage(String normalized) {
    if (normalized.startsWith('data:image')) {
      try {
        final bytes = base64Decode(normalized.split(',').last);
        return Image.memory(bytes, fit: BoxFit.contain);
      } catch (_) {
        return const ErrorImage();
      }
    } else if (normalized.startsWith('http')) {
      return Image.network(
        normalized,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => const ErrorImage(),
      );
    } else {
      return const ErrorImage();
    }
  }

  String _normalizeUrl(String input) {
    if (input.startsWith('data:jpeg')) {
      return input.replaceFirst('data:jpeg', 'data:image/jpeg');
    } else if (input.startsWith('data:jpg')) {
      return input.replaceFirst('data:jpg', 'data:image/jpeg');
    } else if (input.startsWith('data:png')) {
      return input.replaceFirst('data:png', 'data:image/png');
    }
    return input;
  }
}
