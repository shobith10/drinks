import 'package:ailoitte_app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:ailoitte_app/modules/dashboard/models/drink_model.dart';
import 'package:ailoitte_app/modules/dashboard/models/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  void initState() {
    //initially check localy have some data of not call api
    final controller = Provider.of<DashboardController>(context, listen: false);

    List<dynamic> drinkList = controller.getDrinks();

    if (drinkList.isNotEmpty) {
      controller.drinksModel.drinks = drinkList.map((e) {
        return Drinks(
          idDrink: e.idDrink,
          strAlcoholic: e.strAlcoholic,
          strCategory: e.strCategory,
          strDrink: e.strDrink,
          strDrinkThumb: e.strDrinkThumb,
          strGlass: e.strGlass,
          strInstructions: e.strInstructions,
        );
      }).toList();
    }

    if (controller.drinksModel.drinks?.isEmpty ?? true) {
      controller.searchDrink();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<DashboardController>();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
        ),
        body: SingleChildScrollView(
          child: Column(
            // shrinkWrap: true,
            // physics: NeverScrollableScrollPhysics(),
            // physics: AlwaysScrollableScrollPhysics(),
            // padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              TextFormField(
                controller: controller.searchController,
                onChanged: (v) {
                  Future.delayed(Duration(milliseconds: 800)).then((v) async {
                    await controller.searchDrink();
                  });
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10)),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10)),
                    suffixIcon: const Icon(Icons.search)),
              ),
              const SizedBox(
                height: 15,
              ),
              ReorderableListView(
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  children: controller.drinksModel.drinks
                          ?.map((e) => Container(
                                key: Key(e.idDrink),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 100,
                                      color: Colors.grey,
                                      child: Image.network(
                                          e.strDrinkThumb.toString()),
                                    )
                                  ],
                                ),
                              ))
                          .toList() ??
                      [],
                  onReorder: (oldIndex, newIndex) {
                    //rearrange and store again
                    controller.drinksModel.drinks?.insert(
                        newIndex, controller.drinksModel.drinks![oldIndex]);
                    if (oldIndex < newIndex) {
                      controller.drinksModel.drinks?.removeAt(oldIndex);
                    } else {
                      controller.drinksModel.drinks?.removeAt(oldIndex + 1);
                    }

                    controller
                        .saveDrinks(controller.drinksModel.drinks?.map((e) {
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
                    setState(() {});
                  })
            ],
          ),
        ));
  }
}
