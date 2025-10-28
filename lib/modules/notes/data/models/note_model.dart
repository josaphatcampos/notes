import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/note.dart';
import 'note_attachment_model.dart';

part 'note_model.g.dart';

@HiveType(typeId: 0)
class NoteModel extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String content;
  @HiveField(3)
  final DateTime createdAt;
  @HiveField(4)
  final DateTime updatedAt;
  @HiveField(5)
  final List<String> linkedNoteIds;
  @HiveField(6)
  final List<NoteAttachmentModel> attachments;

  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    this.linkedNoteIds = const [],
    this.attachments = const [],
  });

  factory NoteModel.newFrom(String title, String content) {
    final now = DateTime.now();
    return NoteModel(
      id: const Uuid().v4(),
      title: title,
      content: content,
      createdAt: now,
      updatedAt: now,
      linkedNoteIds: const [],
      attachments: const [],
    );
  }

  NoteModel copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? linkedNoteIds,
    List<NoteAttachmentModel>? attachments,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      linkedNoteIds: linkedNoteIds ?? this.linkedNoteIds,
      attachments: attachments ?? this.attachments,
    );
  }

  Note toEntity() => Note(
    id: id,
    title: title,
    content: content,
    createdAt: createdAt,
    updatedAt: updatedAt,
    linkedNoteIds: List<String>.from(linkedNoteIds),
    attachments: attachments.map((a) => a.toEntity()).toList(),
  );

  static NoteModel fromEntity(Note e) => NoteModel(
    id: e.id,
    title: e.title,
    content: e.content,
    createdAt: e.createdAt,
    updatedAt: e.updatedAt,
    linkedNoteIds: List<String>.from(e.linkedNoteIds),
    attachments: e.attachments.map(NoteAttachmentModel.fromEntity).toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'content': content,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
    'linkedNoteIds': linkedNoteIds,
    'attachments': attachments.map((a) => a.toJson()).toList(),
  };

  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
    id: json['id'],
    title: json['title'],
    content: json['content'],
    createdAt: DateTime.parse(json['createdAt']),
    updatedAt: DateTime.parse(json['updatedAt']),
    linkedNoteIds: (json['linkedNoteIds'] as List?)?.cast<String>() ?? const [],
    attachments:
        (json['attachments'] as List?)
            ?.map((e) => NoteAttachmentModel.fromJson(e))
            .toList() ??
        const [],
  );
}
