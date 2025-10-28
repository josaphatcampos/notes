import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:cocus/modules/notes/domain/entities/note.dart';
import 'package:cocus/modules/notes/domain/repositories/note_repository.dart';
import 'package:cocus/modules/notes/domain/usecases/get_notes.dart';

@GenerateMocks([NoteRepository])
import 'get_notes_test.mocks.dart';

void main() {
  late GetNotes usecase;
  late MockNoteRepository mockRepo;

  setUp(() {
    mockRepo = MockNoteRepository();
    usecase = GetNotes(mockRepo);
  });

  final notes = [
    Note(
      id: '1',
      title: 'Test',
      content: 'Note',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  test('should return all notes', () async {
    when(mockRepo.getAll()).thenAnswer((_) async => notes);
    final result = await usecase();
    expect(result, equals(notes));
  });

  test('should throw exception', () {
    when(mockRepo.getAll()).thenThrow(Exception('error'));
    expect(() => usecase(), throwsA(isA<Exception>()));
  });
}
