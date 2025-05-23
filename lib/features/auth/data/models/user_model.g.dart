// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      id: fields[0] as String?,
      firstName: fields[1] as String?,
      lastName: fields[2] as String?,
      fullName: fields[3] as String?,
      username: fields[4] as String?,
      email: fields[5] as String?,
      avatar: fields[6] as String?,
      pin: fields[7] as String?,
      role: fields[8] as String?,
      activity: fields[9] as String?,
      nationalId: fields[10] as String?,
      phoneNumber: fields[11] as String?,
      emailVerified: fields[12] as bool?,
      isInvestor: fields[13] as bool?,
      balance: fields[14] as num?,
      lastLogin: fields[15] as String?,
      favourites: (fields[16] as List?)?.cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.fullName)
      ..writeByte(4)
      ..write(obj.username)
      ..writeByte(5)
      ..write(obj.email)
      ..writeByte(6)
      ..write(obj.avatar)
      ..writeByte(7)
      ..write(obj.pin)
      ..writeByte(8)
      ..write(obj.role)
      ..writeByte(9)
      ..write(obj.activity)
      ..writeByte(10)
      ..write(obj.nationalId)
      ..writeByte(11)
      ..write(obj.phoneNumber)
      ..writeByte(12)
      ..write(obj.emailVerified)
      ..writeByte(13)
      ..write(obj.isInvestor)
      ..writeByte(14)
      ..write(obj.balance)
      ..writeByte(15)
      ..write(obj.lastLogin)
      ..writeByte(16)
      ..write(obj.favourites);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
