import '../entities/note.dart';
import '../entities/note_attachment.dart';

abstract class NoteRepository {
  Future<List<Note>> getAll();

  Future<Note?> getById(String id);

  Future<Note> add(Note note);

  Future<void> update(Note note);

  Future<void> delete(String id);

  Future<List<Note>> search(String query);

  Future<void> sync();

  Future<void> link(String sourceId, String targetId);

  Future<void> unlink(String sourceId, String targetId);

  Future<void> addAttachment(String noteId, NoteAttachment attachment);

  Future<void> removeAttachment(String noteId, String attachmentId);
}
