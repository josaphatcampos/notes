import '../repositories/note_repository.dart';

class DeleteNote {
  final NoteRepository repo;

  DeleteNote(this.repo);

  Future<void> call(String id) => repo.delete(id);
}
