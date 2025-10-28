import 'package:hive_flutter/hive_flutter.dart';

import '../models/note_attachment_model.dart';
import '../models/note_model.dart';

abstract class NoteLocalDataSource {
  Future<List<NoteModel>> getAll();

  Future<NoteModel?> getById(String id);

  Future<NoteModel> add(NoteModel note);

  Future<void> update(NoteModel note);

  Future<void> delete(String id);

  Future<List<NoteModel>> search(String query);
}

class NoteLocalDataSourceHive implements NoteLocalDataSource {
  static const _boxName = 'notesBox';
  late final Box<NoteModel> _box;

  NoteLocalDataSourceHive._(this._box);

  static Future<NoteLocalDataSourceHive> create() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(NoteModelAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(NoteAttachmentModelAdapter());
    }
    final box = await Hive.openBox<NoteModel>(_boxName);
    return NoteLocalDataSourceHive._(box);
  }

  @override
  Future<NoteModel> add(NoteModel note) async {
    await _box.put(note.id, note);
    return note;
  }

  @override
  Future<void> delete(String id) => _box.delete(id);

  @override
  Future<List<NoteModel>> getAll() async => _box.values.toList();

  @override
  Future<NoteModel?> getById(String id) async => _box.get(id);

  @override
  Future<void> update(NoteModel note) => _box.put(note.id, note);

  @override
  Future<List<NoteModel>> search(String query) async {
    if (query.isEmpty) return getAll();
    final q = query.toLowerCase();
    return _box.values
        .where(
          (n) =>
              n.title.toLowerCase().contains(q) ||
              n.content.toLowerCase().contains(q),
        )
        .toList();
  }
}
