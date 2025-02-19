import 'package:hive/hive.dart';

part 'drink_model.g.dart';

@HiveType(typeId: 0)
class Drink {
  @HiveField(0)
  final String idDrink;

  @HiveField(1)
  final String strDrink;

  @HiveField(2)
  final String? strCategory;

  @HiveField(3)
  final String? strAlcoholic;

  @HiveField(4)
  final String? strGlass;

  @HiveField(5)
  final String? strInstructions;

  @HiveField(6)
  final String? strDrinkThumb;

  Drink({
    required this.idDrink,
    required this.strDrink,
    this.strCategory,
    this.strAlcoholic,
    this.strGlass,
    this.strInstructions,
    this.strDrinkThumb,
  });
}
