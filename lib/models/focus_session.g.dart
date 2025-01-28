// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'focus_session.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FocusSessionAdapter extends TypeAdapter<FocusSession> {
  @override
  final int typeId = 1;

  @override
  FocusSession read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FocusSession(
      startTime: fields[0] as DateTime,
      durationInMinutes: fields[1] as int,
      date: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, FocusSession obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.startTime)
      ..writeByte(1)
      ..write(obj.durationInMinutes)
      ..writeByte(2)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FocusSessionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DailyStatsAdapter extends TypeAdapter<DailyStats> {
  @override
  final int typeId = 2;

  @override
  DailyStats read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DailyStats(
      date: fields[0] as DateTime,
      totalFocusMinutes: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, DailyStats obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.totalFocusMinutes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyStatsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UserGoalAdapter extends TypeAdapter<UserGoal> {
  @override
  final int typeId = 3;

  @override
  UserGoal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserGoal(
      dailyGoalMinutes: fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, UserGoal obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.dailyGoalMinutes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserGoalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
