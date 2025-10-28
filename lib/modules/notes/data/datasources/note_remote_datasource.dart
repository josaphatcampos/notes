import '../models/note_model.dart';

abstract class NoteRemoteDataSource {
  Future<List<NoteModel>> pullAll();

  Future<void> pushAll(List<NoteModel> notes);
}
