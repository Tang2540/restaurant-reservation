import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  final List<String> buttonname = [
    'Reserve Table',
    'Order Food',
    'Select Restuarant',
    'Favorite Restuarant',
    'User Profile',
    'Setting',
  ];

  final List<IconData> icons = [
    Icons.table_restaurant,
    Icons.local_dining,
    Icons.storefront,
    Icons.favorite,
    Icons.person,
    Icons.settings,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: GridView.count(
            crossAxisCount: 2,
            children: List.generate(6, (index) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/${index + 2}');
                },
                child: Container(
                  margin: EdgeInsets.all(8.0),
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text(buttonname[index])],
                  ),
                ),
              );
            })));
  }
}
