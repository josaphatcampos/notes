import '../entities/note.dart';
import '../repositories/note_repository.dart';

class SearchNotes {
  final NoteRepository repo;

  SearchNotes(this.repo);

  Future<List<Note>> call(String query) => repo.search(query);
}
