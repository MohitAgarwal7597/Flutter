// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountAdapter extends TypeAdapter<Account> {
  @override
  final int typeId = 0;

  @override
  Account read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Account(
      name: fields[0] as String,
      number: fields[1] as String,
      accountNumber: fields[2] as String,
      cifNumber: fields[3] as String,
      openingDate: fields[4] as DateTime,
      closingDate: fields[5] as DateTime,
      schemeType: fields[6] as String,
      denomination: fields[7] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Account obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.number)
      ..writeByte(2)
      ..write(obj.accountNumber)
      ..writeByte(3)
      ..write(obj.cifNumber)
      ..writeByte(4)
      ..write(obj.openingDate)
      ..writeByte(5)
      ..write(obj.closingDate)
      ..writeByte(6)
      ..write(obj.schemeType)
      ..writeByte(7)
      ..write(obj.denomination);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
