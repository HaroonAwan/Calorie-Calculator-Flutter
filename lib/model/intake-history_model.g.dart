// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intake-history_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IntakeHistoryModelAdapter extends TypeAdapter<IntakeHistoryModel> {
  @override
  final int typeId = 1;

  @override
  IntakeHistoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IntakeHistoryModel(
      createdAt: fields[0] as DateTime,
      dailyGoal: fields[1] as int,
      intakes: (fields[2] as List)?.cast<IntakeModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, IntakeHistoryModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.createdAt)
      ..writeByte(1)
      ..write(obj.dailyGoal)
      ..writeByte(2)
      ..write(obj.intakes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IntakeHistoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
