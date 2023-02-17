// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_db.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodoBoxAdapter extends TypeAdapter<TodoBox> {
  @override
  final int typeId = 0;

  @override
  TodoBox read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TodoBox(
      id: fields[0] as int,
      title: fields[1] as String,
      description: fields[2] as String,
      tags: fields[3] as String,
      isCompleted: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, TodoBox obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.tags)
      ..writeByte(4)
      ..write(obj.isCompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoBoxAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
