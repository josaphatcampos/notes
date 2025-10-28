import '../repositories/note_repository.dart';

class SyncNotes {
  final NoteRepository repo;

  SyncNotes(this.repo);

  Future<void> call() => repo.sync();
}
