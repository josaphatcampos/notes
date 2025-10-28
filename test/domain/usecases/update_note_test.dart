import 'package:cocus/modules/notes/domain/entities/note.dart';
import 'package:cocus/modules/notes/domain/repositories/note_repository.dart';
import 'package:cocus/modules/notes/domain/usecases/update_note.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([NoteRepository])
import 'update_note_test.mocks.dart';

void main() {
  late UpdateNote usecase;
  late MockNoteRepository mockRepo;

  setUp(() {
    mockRepo = MockNoteRepository();
    usecase = UpdateNote(mockRepo);
  });

  final note = Note(
    id: '1',
    title: 'Updated',
    content: 'Updated content',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  test('should call repository.update', () async {
    when(mockRepo.update(any)).thenAnswer((_) async => Future.value());

    await usecase(note);

    verify(mockRepo.update(note)).called(1);
  });

  test('should throw exception when update fails', () {
    when(mockRepo.update(any)).thenThrow(Exception('error'));
    expect(() => usecase(note), throwsA(isA<Exception>()));
  });
}
