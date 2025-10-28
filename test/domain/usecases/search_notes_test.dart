import 'package:cocus/modules/notes/domain/entities/note.dart';
import 'package:cocus/modules/notes/domain/repositories/note_repository.dart';
import 'package:cocus/modules/notes/domain/usecases/search_notes.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([NoteRepository])
import 'search_notes_test.mocks.dart';

void main() {
  late SearchNotes usecase;
  late MockNoteRepository mockRepo;

  setUp(() {
    mockRepo = MockNoteRepository();
    usecase = SearchNotes(mockRepo);
  });

  const query = 'flutter';
  final notes = [
    Note(
      id: '1',
      title: 'Flutter Tips',
      content: 'Use Provider!',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  test('should return notes by query', () async {
    when(mockRepo.search(any)).thenAnswer((_) async => notes);
    final result = await usecase(query);
    expect(result, equals(notes));
  });

  test('should throw exception', () {
    when(mockRepo.search(any)).thenThrow(Exception('error'));
    expect(() => usecase(query), throwsA(isA<Exception>()));
  });
}
