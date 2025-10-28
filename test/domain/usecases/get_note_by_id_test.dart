import 'package:cocus/modules/notes/domain/entities/note.dart';
import 'package:cocus/modules/notes/domain/repositories/note_repository.dart';
import 'package:cocus/modules/notes/domain/usecases/get_note_by_id.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([NoteRepository])
import 'get_note_by_id_test.mocks.dart';

void main() {
  late GetNoteById usecase;
  late MockNoteRepository mockRepo;

  setUp(() {
    mockRepo = MockNoteRepository();
    usecase = GetNoteById(mockRepo);
  });

  final note = Note(
    id: '1',
    title: 'Title',
    content: 'Body',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  test('should get note by id', () async {
    when(mockRepo.getById(any)).thenAnswer((_) async => note);

    final result = await usecase('1');

    expect(result, equals(note));
    verify(mockRepo.getById('1')).called(1);
  });

  test('should throw when repository throws', () {
    when(mockRepo.getById(any)).thenThrow(Exception('error'));
    expect(() => usecase('1'), throwsA(isA<Exception>()));
  });
}
