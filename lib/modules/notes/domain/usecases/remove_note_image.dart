import '../repositories/note_repository.dart';

class RemoveNoteImage {
  final NoteRepository repo;

  RemoveNoteImage(this.repo);

  Future<void> call(String noteId, String attachmentId) =>
      repo.removeAttachment(noteId, attachmentId);
}
