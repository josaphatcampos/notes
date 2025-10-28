class NoteAttachment {
  final String id;
  final String name;
  final String url;
  final String mimeType;
  final DateTime createdAt;

  const NoteAttachment({
    required this.id,
    required this.name,
    required this.url,
    required this.mimeType,
    required this.createdAt,
  });

  bool get isBase64 => url.startsWith('data:') || url.contains(';base64,');

  NoteAttachment copyWith({
    String? id,
    String? name,
    String? url,
    String? mimeType,
    DateTime? createdAt,
  }) {
    return NoteAttachment(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
      mimeType: mimeType ?? this.mimeType,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
