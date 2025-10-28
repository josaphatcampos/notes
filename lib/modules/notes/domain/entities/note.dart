import 'note_attachment.dart';

class Note {
  final String id;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String> linkedNoteIds;
  final List<NoteAttachment> attachments;

  const Note({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    this.linkedNoteIds = const [],
    this.attachments = const [],
  });

  Note copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? linkedNoteIds,
    List<NoteAttachment>? attachments,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      linkedNoteIds: linkedNoteIds ?? this.linkedNoteIds,
      attachments: attachments ?? this.attachments,
    );
  }

  String get preview =>
      content.length > 80 ? '${content.substring(0, 80)}...' : content;
}
