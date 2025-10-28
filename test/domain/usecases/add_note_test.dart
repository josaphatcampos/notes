import 'package:cocus/modules/notes/domain/entities/note.dart';
import 'package:cocus/modules/notes/domain/repositories/note_repository.dart';
import 'package:cocus/modules/notes/domain/usecases/add_note.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([NoteRepository])
import 'add_note_test.mocks.dart';

void main() {
  late AddNote usecase;
  late MockNoteRepository mockRepo;

  setUp(() {
    mockRepo = MockNoteRepository();
    usecase = AddNote(mockRepo);
  });

  final note = Note(
    id: '1',
    title: 'Test Note',
    content: 'Hello world',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  test('should add note and return it', () async {
    when(mockRepo.add(any)).thenAnswer((_) async => note);

    final result = await usecase(note);

    expect(result, equals(note));
    verify(mockRepo.add(note)).called(1);
  });

  test('should throw when repository throws', () {
    when(mockRepo.add(any)).thenThrow(Exception('error'));
    expect(() => usecase(note), throwsA(isA<Exception>()));
  });
}
