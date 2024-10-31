import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_app/component/favoritesmodel.dart';
import 'package:team_app/fooddetailmodel.dart';
import 'package:team_app/pages/favoritepage.dart';
import 'package:team_app/pages/orderfood.dart';
import 'package:team_app/pages/homepage.dart';
import 'package:team_app/pages/restaurantsearch.dart';
import 'package:team_app/pages/tablemap.dart';
import 'package:team_app/pages/userprofile.dart';
import 'package:team_app/pages/setting.dart';
import 'package:team_app/tablemodel.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => TableModel()),
      ChangeNotifierProvider(create: (context) => FoodDetailModel()),
      ChangeNotifierProvider(create: (context) => FavoritesModel())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 103, 250, 81)),
        useMaterial3: true,
      ),
      initialRoute: '/1',
      routes: {
        '/1': (context) => Homepage(),
        '/2': (context) => TableMapPage(),
        '/3': (context) => OrderFood(),
        '/4': (context) => RestaurantSearchPage(),
        '/5': (context) => FavoritesPage(),
        '/6': (context) => UserProfilePage(),
        '/7': (context) => SettingsPage()
      },
    );
  }
}
