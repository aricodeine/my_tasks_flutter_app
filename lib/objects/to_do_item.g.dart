// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'to_do_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ToDoItemAdapter extends TypeAdapter<ToDoItem> {
  @override
  final int typeId = 0;

  @override
  ToDoItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ToDoItem(
      itemName: fields[0] as String,
      isCompleted: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ToDoItem obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.itemName)
      ..writeByte(1)
      ..write(obj.isCompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToDoItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
