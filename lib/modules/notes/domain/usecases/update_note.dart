import '../entities/note.dart';
import '../repositories/note_repository.dart';

class UpdateNote {
  final NoteRepository repo;

  UpdateNote(this.repo);

  Future<void> call(Note note) => repo.update(note);
}
