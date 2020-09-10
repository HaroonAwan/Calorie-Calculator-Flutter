// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intake_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IntakeModelAdapter extends TypeAdapter<IntakeModel> {
  @override
  final int typeId = 2;

  @override
  IntakeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IntakeModel(
      calories: fields[1] as int,
      description: fields[2] as String,
      time: fields[0] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, IntakeModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.time)
      ..writeByte(1)
      ..write(obj.calories)
      ..writeByte(2)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IntakeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
