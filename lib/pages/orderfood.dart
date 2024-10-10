import 'package:flutter/material.dart';
import 'package:team_app/component/demo_component.dart';

class OrderFood extends StatelessWidget {
  final List<String> menu = ['Fish & Chips', 'Y'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Order Food'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: ListView.separated(
            padding: EdgeInsets.all(8.0),
            itemCount: menu.length,
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemBuilder: (context, index) {
              return Container(
                  height: 200,
                  color: Color.fromARGB(255, 103, 250, 81),
                  child: Center(
                      child:
                          CardWidget(cardData: CardData(name: menu[index]))));
            }));
  }
}
