import 'package:flutter/material.dart';
import 'package:team_app/api.dart';
import 'package:team_app/pages/booking.dart';
import 'package:team_app/tablemodel.dart';
import 'package:provider/provider.dart';

class TableDetailsPage extends StatefulWidget {
  @override
  State<TableDetailsPage> createState() => _TableDetailsPageState();
}

class _TableDetailsPageState extends State<TableDetailsPage> {
  List<dynamic> bookings = [];
  final PostController controller = PostController(PostFirebaseService());
  bool isLoading = false;

  Future<void> _getBookings(int tableId) async {
    setState(() {
      isLoading = true;
    });

    try {
      print('Fetching bookings for table ID: $tableId'); // Debug print
      final newBookings = await controller.fetchTableBookings(tableId);
      if (mounted) {
        setState(() {
          bookings = newBookings;
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching bookings: $e'); // Debug print
      if (mounted) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load bookings: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TableModel>(builder: (context, table, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Table ${table.tableName} Details'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.table_restaurant, size: 100),
                    SizedBox(height: 20),
                    Text(
                      'Table ${table.tableName}',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                            table.increment();
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () async {
                        // Debug print
                        print('TableID before _getBookings: ${table.tableId}');

                        // Make sure tableId is not null or 0
                        if (table.tableId <= 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Invalid table ID'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        await _getBookings(table.tableId);

                        if (mounted) {
                          table.addDate(bookings);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookingPage(),
                            ),
                          );
                        }
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
