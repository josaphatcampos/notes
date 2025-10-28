import '../repositories/note_repository.dart';

class UnlinkNote {
  final NoteRepository repo;

  UnlinkNote(this.repo);

  Future<void> call({required String sourceId, required String targetId}) =>
      repo.unlink(sourceId, targetId);
}
