import '../../domain/entities/note.dart';
import '../../domain/entities/note_attachment.dart';
import '../../domain/repositories/note_repository.dart';
import '../datasources/note_local_datasource.dart';
import '../datasources/note_remote_datasource.dart';
import '../models/note_attachment_model.dart';
import '../models/note_model.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteLocalDataSource local;
  final NoteRemoteDataSource? remote;

  NoteRepositoryImpl({required this.local, this.remote});

  @override
  Future<Note> add(Note note) async {
    final model = NoteModel.fromEntity(note);
    final saved = await local.add(model);
    return saved.toEntity();
  }

  @override
  Future<void> delete(String id) => local.delete(id);

  @override
  Future<List<Note>> getAll() async {
    final list = await local.getAll();
    return list.map((m) => m.toEntity()).toList();
  }

  @override
  Future<Note?> getById(String id) async {
    final m = await local.getById(id);
    return m?.toEntity();
  }

  @override
  Future<List<Note>> search(String query) async {
    final list = await local.search(query);
    return list.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> update(Note note) async {
    final updated = NoteModel.fromEntity(
      note.copyWith(updatedAt: DateTime.now()),
    );
    await local.update(updated);
  }

  @override
  Future<void> link(String sourceId, String targetId) async {
    final m = await local.getById(sourceId);
    if (m == null) return;
    if (m.linkedNoteIds.contains(targetId)) return;
    final updated = m.copyWith(
      linkedNoteIds: [...m.linkedNoteIds, targetId],
      updatedAt: DateTime.now(),
    );
    await local.update(updated);
  }

  @override
  Future<void> unlink(String sourceId, String targetId) async {
    final m = await local.getById(sourceId);
    if (m == null) return;
    final updated = m.copyWith(
      linkedNoteIds: m.linkedNoteIds.where((id) => id != targetId).toList(),
      updatedAt: DateTime.now(),
    );
    await local.update(updated);
  }

  @override
  Future<void> addAttachment(String noteId, NoteAttachment attachment) async {
    final m = await local.getById(noteId);
    if (m == null) return;
    final updated = m.copyWith(
      attachments: [
        ...m.attachments,
        NoteAttachmentModel.fromEntity(attachment),
      ],
      updatedAt: DateTime.now(),
    );
    await local.update(updated);
  }

  @override
  Future<void> removeAttachment(String noteId, String attachmentId) async {
    final m = await local.getById(noteId);
    if (m == null) return;
    final updated = m.copyWith(
      attachments: m.attachments.where((a) => a.id != attachmentId).toList(),
      updatedAt: DateTime.now(),
    );
    await local.update(updated);
  }

  @override
  Future<void> sync() async {}
}
