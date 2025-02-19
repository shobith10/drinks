import 'package:ailoitte_app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:ailoitte_app/modules/dashboard/models/drink_model.dart';
import 'package:ailoitte_app/modules/dashboard/view/dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(DrinkAdapter());
  await Hive.openBox('drinksBox');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DashboardController>(
            create: (_) => DashboardController())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: DashboardView(),
      ),
    );
  }
}
