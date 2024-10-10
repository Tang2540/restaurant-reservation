import 'package:flutter/material.dart';
import 'package:team_app/pages/booking.dart';
import 'package:team_app/pages/tabledetail.dart';
import 'package:team_app/tablemodel.dart';
import 'package:provider/provider.dart';

class TableMapPage extends StatelessWidget {
  final List<String> characters = List.generate(26, (i) {
    String letter = String.fromCharCode(65 + i);
    return List.generate(4, (j) => '$letter${j + 1}').join(',');
  }).expand((element) => element.split(',')).toList();

  final List<bool> status = List.generate(104, (index) => index % 2 == 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Table Map'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
          ),
          itemCount: characters.length,
          itemBuilder: (context, index) {
            bool isAvailable = status[index];
            return GestureDetector(
              onTap: () {
                if (isAvailable) {
                  final detail = context.read<TableModel>();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TableDetailsPage(),
                    ),
                  );
                  detail.addID(characters[index]);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Table ${characters[index]} is reserved!'),
                    backgroundColor: Colors.red,
                  ));
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isAvailable ? Colors.green[300] : Colors.red[300],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                  child: Text(
                    characters[index],
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
