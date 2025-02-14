// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 3;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      email: fields[0] as String,
      username: fields[6] as String,
      firstName: fields[1] as String,
      lastName: fields[2] as String,
      isVerified: fields[3] as bool,
      isStaff: fields[4] as bool,
      isAdmin: fields[5] as bool,
      id: fields[7] as int,
      isCrewMember: fields[8] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.email)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.isVerified)
      ..writeByte(4)
      ..write(obj.isStaff)
      ..writeByte(5)
      ..write(obj.isAdmin)
      ..writeByte(6)
      ..write(obj.username)
      ..writeByte(7)
      ..write(obj.id)
      ..writeByte(8)
      ..write(obj.isCrewMember);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
