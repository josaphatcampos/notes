import 'package:cocus/modules/notes/domain/repositories/note_repository.dart';
import 'package:cocus/modules/notes/domain/usecases/unlink_note.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([NoteRepository])
import 'unlink_note_test.mocks.dart';

void main() {
  late UnlinkNote usecase;
  late MockNoteRepository mockRepo;

  setUp(() {
    mockRepo = MockNoteRepository();
    usecase = UnlinkNote(mockRepo);
  });

  const sourceId = 'note_1';
  const targetId = 'note_2';

  test('should unlink notes successfully', () async {
    when(mockRepo.unlink(any, any)).thenAnswer((_) async => Future.value());

    await usecase(sourceId: sourceId, targetId: targetId);

    verify(mockRepo.unlink(sourceId, targetId)).called(1);
  });

  test('should throw exception when unlink fails', () {
    when(mockRepo.unlink(any, any)).thenThrow(Exception('unlink error'));

    expect(
      () => usecase(sourceId: sourceId, targetId: targetId),
      throwsA(isA<Exception>()),
    );
  });
}
