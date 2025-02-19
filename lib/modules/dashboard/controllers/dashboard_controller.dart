import 'dart:convert';

import 'package:ailoitte_app/modules/dashboard/models/drink_model.dart';
import 'package:ailoitte_app/modules/dashboard/models/models.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class DashboardController extends ChangeNotifier {
  // https://www.thecocktaildb.com/api/json/v1/1/search.php?s=rum

  TextEditingController searchController = TextEditingController(text: "rum");
  final dio = Dio();

  bool _loading = false;
  bool get loading => _loading;

  set loading(bool newLoad) {
    _loading = newLoad;
    notifyListeners();
  }

  DrinksModel _drinksModel = DrinksModel();
  DrinksModel get drinksModel => _drinksModel;
  set drinksModel(DrinksModel newVal) {
    _drinksModel = newVal;
    notifyListeners();
  }

  searchDrink() async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        loading = true;
      });

      Response response;
      response = await dio.get(
          'https://www.thecocktaildb.com/api/json/v1/1/search.php?',
          queryParameters: {'s': searchController.text});

      if (response.statusCode == 200) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          loading = false;
        });
        print(response.data);
        drinksModel = DrinksModel.fromJson(response.data);
        saveDrinks(drinksModel.drinks?.map((e) {
              return Drink(
                idDrink: e.idDrink.toString(),
                strDrink: e.strDrink.toString(),
                strCategory: e.strCategory,
                strAlcoholic: e.strAlcoholic,
                strDrinkThumb: e.strDrinkThumb,
                strGlass: e.strGlass,
                strInstructions: e.strInstructions,
              );
            }).toList() ??
            []);
      }
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        loading = false;
      });
    }
  }

  Future<void> saveDrinks(List<Drink> drinks) async {
    var box = Hive.box('drinksBox');
    await box.put('drinksList', drinks);
  }

  List<dynamic> getDrinks() {
    var box = Hive.box('drinksBox');
    return box.get('drinksList', defaultValue: <Drink>[]);
  }
}
