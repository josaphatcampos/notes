import 'package:cocus/modules/notes/domain/entities/note_attachment.dart';
import 'package:cocus/modules/notes/domain/repositories/note_repository.dart';
import 'package:cocus/modules/notes/domain/usecases/add_note_image.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([NoteRepository])
import 'add_note_image_test.mocks.dart';

void main() {
  late AddNoteImage usecase;
  late MockNoteRepository mockRepo;

  setUp(() {
    mockRepo = MockNoteRepository();
    usecase = AddNoteImage(mockRepo);
  });

  const noteId = 'note_1';

  final attachment = NoteAttachment(
    id: 'att_1',
    name: 'photo.png',
    mimeType: 'image/png',
    url: 'https://example.com/photo.png',
    createdAt: DateTime.now(),
  );

  test('should add attachment to a note successfully', () async {
    when(
      mockRepo.addAttachment(any, any),
    ).thenAnswer((_) async => Future.value());

    await usecase(noteId, attachment);

    verify(mockRepo.addAttachment(noteId, attachment)).called(1);
  });

  test('should throw exception when repository fails', () {
    when(mockRepo.addAttachment(any, any)).thenThrow(Exception('failed'));

    expect(() => usecase(noteId, attachment), throwsA(isA<Exception>()));
  });
}
