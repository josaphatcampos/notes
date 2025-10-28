import 'package:cocus/modules/notes/domain/repositories/note_repository.dart';
import 'package:cocus/modules/notes/domain/usecases/delete_note.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([NoteRepository])
import 'delete_note_test.mocks.dart';

void main() {
  late DeleteNote usecase;
  late MockNoteRepository mockRepo;

  setUp(() {
    mockRepo = MockNoteRepository();
    usecase = DeleteNote(mockRepo);
  });

  const id = 'note1';

  test('should delete note successfully', () async {
    when(mockRepo.delete(any)).thenAnswer((_) async => Future.value());
    await usecase(id);
    verify(mockRepo.delete(id)).called(1);
  });

  test('should throw on delete error', () {
    when(mockRepo.delete(any)).thenThrow(Exception('error'));
    expect(() => usecase(id), throwsA(isA<Exception>()));
  });
}
