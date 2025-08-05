// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MyNotificationAdapter extends TypeAdapter<MyNotification> {
  @override
  final int typeId = 0;

  @override
  MyNotification read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MyNotification(
      title: fields[0] as String,
      body: fields[1] as String,
      receivedAt: fields[2] as DateTime,
      imageUrl: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MyNotification obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.body)
      ..writeByte(2)
      ..write(obj.receivedAt)
      ..writeByte(3)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyNotificationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
