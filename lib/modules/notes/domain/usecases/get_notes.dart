import '../entities/note.dart';
import '../repositories/note_repository.dart';

class GetNotes {
  final NoteRepository repo;

  GetNotes(this.repo);

  Future<List<Note>> call() => repo.getAll();
}
