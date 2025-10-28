import '../entities/note.dart';
import '../repositories/note_repository.dart';

class AddNote {
  final NoteRepository repo;

  AddNote(this.repo);

  Future<Note> call(Note note) => repo.add(note);
}
