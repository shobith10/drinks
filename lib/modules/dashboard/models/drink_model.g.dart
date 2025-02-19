// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drink_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DrinkAdapter extends TypeAdapter<Drink> {
  @override
  final int typeId = 0;

  @override
  Drink read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Drink(
      idDrink: fields[0] as String,
      strDrink: fields[1] as String,
      strCategory: fields[2] as String?,
      strAlcoholic: fields[3] as String?,
      strGlass: fields[4] as String?,
      strInstructions: fields[5] as String?,
      strDrinkThumb: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Drink obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.idDrink)
      ..writeByte(1)
      ..write(obj.strDrink)
      ..writeByte(2)
      ..write(obj.strCategory)
      ..writeByte(3)
      ..write(obj.strAlcoholic)
      ..writeByte(4)
      ..write(obj.strGlass)
      ..writeByte(5)
      ..write(obj.strInstructions)
      ..writeByte(6)
      ..write(obj.strDrinkThumb);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DrinkAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
