import '../entities/note.dart';
import '../repositories/note_repository.dart';

class GetNoteById {
  final NoteRepository repo;

  GetNoteById(this.repo);

  Future<Note?> call(String id) => repo.getById(id);
}
