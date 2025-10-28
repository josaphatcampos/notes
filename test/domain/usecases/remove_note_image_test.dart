import 'package:cocus/modules/notes/domain/repositories/note_repository.dart';
import 'package:cocus/modules/notes/domain/usecases/remove_note_image.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([NoteRepository])
import 'remove_note_image_test.mocks.dart';

void main() {
  late RemoveNoteImage usecase;
  late MockNoteRepository mockRepo;

  setUp(() {
    mockRepo = MockNoteRepository();
    usecase = RemoveNoteImage(mockRepo);
  });

  const noteId = 'n1';
  const attachmentId = 'a1';

  test('should remove attachment', () async {
    when(
      mockRepo.removeAttachment(any, any),
    ).thenAnswer((_) async => Future.value());
    await usecase(noteId, attachmentId);
    verify(mockRepo.removeAttachment(noteId, attachmentId)).called(1);
  });

  test('should throw exception when fails', () {
    when(mockRepo.removeAttachment(any, any)).thenThrow(Exception('error'));
    expect(() => usecase(noteId, attachmentId), throwsA(isA<Exception>()));
  });
}
