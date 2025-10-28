import '../repositories/note_repository.dart';

class LinkNote {
  final NoteRepository repo;

  LinkNote(this.repo);

  Future<void> call({required String sourceId, required String targetId}) =>
      repo.link(sourceId, targetId);
}
