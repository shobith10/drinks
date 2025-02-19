import 'dart:convert';

DrinksModel drinkModelFromJson(String str) =>
    DrinksModel.fromJson(json.decode(str));

String drinkModelToJson(DrinksModel data) => json.encode(data.toJson());

class DrinksModel {
  List<Drinks>? drinks;

  DrinksModel({
    this.drinks,
  });

  factory DrinksModel.fromJson(Map<String, dynamic> json) => DrinksModel(
        drinks: json["drinks"] == "no data found"
            ? []
            : List<Drinks>.from(json["drinks"].map((x) => Drinks.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "drinks": List<dynamic>.from(drinks?.map((x) => x.toJson()) ?? []),
      };
}

class Drinks {
  String idDrink;
  String? strDrink;
  String? strCategory;
  String? strAlcoholic;
  String? strGlass;
  String? strInstructions;
  String? strDrinkThumb;

  Drinks({
    required this.idDrink,
    this.strDrink,
    this.strCategory,
    this.strAlcoholic,
    this.strGlass,
    this.strInstructions,
    this.strDrinkThumb,
  });

  factory Drinks.fromJson(Map<String, dynamic> json) => Drinks(
        idDrink: json["idDrink"],
        strDrink: json["strDrink"],
        strCategory: json["strCategory"],
        strAlcoholic: json["strAlcoholic"],
        strGlass: json["strGlass"],
        strInstructions: json["strInstructions"],
        strDrinkThumb: json["strDrinkThumb"],
      );

  Map<String, dynamic> toJson() => {
        "idDrink": idDrink,
        "strDrink": strDrink,
        "strCategory": strCategory,
        "strAlcoholic": strAlcoholic,
        "strGlass": strGlass,
        "strInstructions": strInstructions,
        "strDrinkThumb": strDrinkThumb,
      };
}
