import 'package:hive/hive.dart';

import '../../domain/entities/note_attachment.dart';

part 'note_attachment_model.g.dart';

@HiveType(typeId: 1)
class NoteAttachmentModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String url;
  @HiveField(3)
  final String mimeType;
  @HiveField(4)
  final DateTime createdAt;

  const NoteAttachmentModel({
    required this.id,
    required this.name,
    required this.url,
    required this.mimeType,
    required this.createdAt,
  });

  static String normalizeUrl(String input, String mimeType) {
    if (input.startsWith('data:jpeg')) {
      return input.replaceFirst('data:jpeg', 'data:image/jpeg');
    } else if (input.startsWith('data:png')) {
      return input.replaceFirst('data:png', 'data:image/png');
    } else if (input.startsWith('data:jpg')) {
      return input.replaceFirst('data:jpg', 'data:image/jpeg');
    }
    return input;
  }

  NoteAttachment toEntity() => NoteAttachment(
    id: id,
    name: name,
    url: normalizeUrl(url, mimeType),
    mimeType: mimeType,
    createdAt: createdAt,
  );

  static NoteAttachmentModel fromEntity(NoteAttachment e) =>
      NoteAttachmentModel(
        id: e.id,
        name: e.name,
        url: normalizeUrl(e.url, e.mimeType),
        mimeType: e.mimeType,
        createdAt: e.createdAt,
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'url': url,
    'mimeType': mimeType,
    'createdAt': createdAt.toIso8601String(),
  };

  factory NoteAttachmentModel.fromJson(Map<String, dynamic> json) =>
      NoteAttachmentModel(
        id: json['id'] as String,
        name: json['name'] as String,
        url: normalizeUrl(json['url'] as String, json['mimeType'] as String),
        mimeType: json['mimeType'] as String,
        createdAt: DateTime.parse(json['createdAt'] as String),
      );
}
