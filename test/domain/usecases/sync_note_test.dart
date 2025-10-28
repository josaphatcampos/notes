import 'package:cocus/modules/notes/domain/repositories/note_repository.dart';
import 'package:cocus/modules/notes/domain/usecases/sync_note.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([NoteRepository])
import 'sync_note_test.mocks.dart';

void main() {
  late SyncNotes usecase;
  late MockNoteRepository mockRepo;

  setUp(() {
    mockRepo = MockNoteRepository();
    usecase = SyncNotes(mockRepo);
  });

  test('should call repository.sync()', () async {
    when(mockRepo.sync()).thenAnswer((_) async => Future.value());

    await usecase();

    verify(mockRepo.sync()).called(1);
  });

  test('should throw when sync fails', () {
    when(mockRepo.sync()).thenThrow(Exception('error'));

    expect(() => usecase(), throwsA(isA<Exception>()));
  });
}
