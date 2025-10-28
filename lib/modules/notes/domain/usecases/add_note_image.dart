import '../entities/note_attachment.dart';
import '../repositories/note_repository.dart';

class AddNoteImage {
  final NoteRepository repo;

  AddNoteImage(this.repo);

  Future<void> call(String noteId, NoteAttachment attachment) =>
      repo.addAttachment(noteId, attachment);
}
