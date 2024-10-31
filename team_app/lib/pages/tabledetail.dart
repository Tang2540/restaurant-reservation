import 'package:flutter/material.dart';
import 'package:team_app/pages/booking.dart';
import 'package:team_app/tablemodel.dart';
import 'package:provider/provider.dart';

class TableDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TableModel>(builder: (context, table, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Table ${table.tableID} Details'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.table_restaurant, size: 100),
              SizedBox(height: 20),
              Text(
                'Table ${table.tableID}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove_circle),
                    onPressed: () {
                      table.decrement();
                    },
                  ),
                  Text(
                    table.count.toString(),
                    style: TextStyle(fontSize: 24),
                  ),
                  IconButton(
                    icon: Icon(Icons.add_circle),
                    onPressed: () {
                      final table = context.read<TableModel>();
                      table.increment();
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookingPage(),
                    ),
                  );
                },
                icon: Icon(Icons.event_available),
                label: Text('Reserve Seat'),
              ),
            ],
          ),
        ),
      );
    });
  }
}
