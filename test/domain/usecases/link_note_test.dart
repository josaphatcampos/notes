import 'package:cocus/modules/notes/domain/repositories/note_repository.dart';
import 'package:cocus/modules/notes/domain/usecases/link_note.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([NoteRepository])
import 'link_note_test.mocks.dart';

void main() {
  late LinkNote usecase;
  late MockNoteRepository mockRepo;

  setUp(() {
    mockRepo = MockNoteRepository();
    usecase = LinkNote(mockRepo);
  });

  const sourceId = 'note_1';
  const targetId = 'note_2';

  test('should link two notes successfully', () async {
    when(mockRepo.link(any, any)).thenAnswer((_) async => Future.value());

    await usecase(sourceId: sourceId, targetId: targetId);

    verify(mockRepo.link(sourceId, targetId)).called(1);
  });

  test('should throw exception when repository fails', () {
    when(mockRepo.link(any, any)).thenThrow(Exception('failed'));

    expect(
      () => usecase(sourceId: sourceId, targetId: targetId),
      throwsA(isA<Exception>()),
    );
  });
}
