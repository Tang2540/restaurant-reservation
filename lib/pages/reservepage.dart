import 'package:flutter/material.dart';
import 'package:team_app/component/demo_component.dart';

class Reservetable extends StatelessWidget {
  final List<String> entries = List.generate(26, (i) {
    String letter = String.fromCharCode(65 + i);
    return List.generate(4, (j) => '$letter${j + 1}').join(',');
  }).expand((element) => element.split(',')).toList();


final List<Color> colorCodes = List.generate(104, (index) {
  int step = index % 4;
  switch (step) {
    case 0:
      return Color.fromARGB(255, 103, 250, 81); 
    case 1:
      return Color.fromARGB(255, 82, 180, 67); 
    case 2:
      return Color.fromARGB(255, 70, 137, 59);
    case 3: 
      return Color.fromARGB(255, 58, 102, 51); 
    default:
      return Color.fromARGB(255, 103, 250, 81); 
  }
});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Reserve Tables'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: ListView.separated(
            padding: EdgeInsets.all(8.0),
            itemCount: entries.length,
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemBuilder: (context, index) {
              return Container(
                  height: 200,
                  color: colorCodes[index],
                  child: Center(
                      child: CardWidget(
                          cardData: CardData(name: entries[index]))));
            }));
  }
}