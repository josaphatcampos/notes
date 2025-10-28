// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_attachment_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteAttachmentModelAdapter extends TypeAdapter<NoteAttachmentModel> {
  @override
  final int typeId = 1;

  @override
  NoteAttachmentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteAttachmentModel(
      id: fields[0] as String,
      name: fields[1] as String,
      url: fields[2] as String,
      mimeType: fields[3] as String,
      createdAt: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, NoteAttachmentModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.url)
      ..writeByte(3)
      ..write(obj.mimeType)
      ..writeByte(4)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteAttachmentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
