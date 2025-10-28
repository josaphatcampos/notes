import 'dart:convert';

import 'package:flutter/material.dart';

import '../components/error_image.dart';
import 'attachment_fullscreen_image.dart';

class AttachmentImageWidget extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final BoxFit fit;
  final BorderRadius borderRadius;
  final VoidCallback? onTap;

  const AttachmentImageWidget({
    super.key,
    required this.url,
    this.width = 100,
    this.height = 100,
    this.fit = BoxFit.cover,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final tag = url.hashCode.toString();
    final normalized = _normalizeUrl(url);

    Widget child;

    if (normalized.startsWith('data:image')) {
      try {
        final bytes = base64Decode(normalized.split(',').last);
        child = Image.memory(
          bytes,
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (_, __, ___) => const ErrorImage(),
        );
      } catch (e) {
        debugPrint('Base64 decode error: $e');
        child = const ErrorImage();
      }
    } else if (normalized.startsWith('http')) {
      child = Image.network(
        normalized,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, __, ___) => const ErrorImage(),
      );
    } else {
      child = const ErrorImage();
    }

    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        } else {
          _openPreview(context, normalized, tag);
        }
      },
      child: Hero(
        tag: tag,
        child: ClipRRect(borderRadius: borderRadius, child: child),
      ),
    );
  }

  void _openPreview(BuildContext context, String normalized, String tag) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.9),
      builder: (_) => AttachmentFullscreenImage(tag: tag, url: normalized),
    );
  }

  String _normalizeUrl(String input) {
    if (input.startsWith('data:jpeg')) {
      return input.replaceFirst('data:jpeg', 'data:image/jpeg');
    } else if (input.startsWith('data:jpg')) {
      return input.replaceFirst('data:jpg', 'data:image/jpeg');
    } else if (input.startsWith('data:png')) {
      return input.replaceFirst('data:png', 'data:image/png');
    } else if (input.startsWith('data:gif')) {
      return input.replaceFirst('data:gif', 'data:image/gif');
    }
    return input;
  }
}
