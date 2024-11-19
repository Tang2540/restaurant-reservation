import 'package:flutter/material.dart';
import 'package:team_app/api.dart';
import 'package:team_app/pages/booking.dart';
import 'package:team_app/pages/tabledetail.dart';
import 'package:team_app/tablemodel.dart';
import 'package:provider/provider.dart';

class TableMapPage extends StatefulWidget {
  @override
  State<TableMapPage> createState() => _TableMapPageState();
}

class _TableMapPageState extends State<TableMapPage> {
  List<TableR> tables = List.empty();
  bool isLoading = false;
  PostController controller = PostController(PostFirebaseService());

  @override
  void initState() {
    super.initState();
    controller.onSync.listen((bool syncState) {
      setState(() {
        isLoading = syncState;
      });
    });
    _getTables();
  }

  void _getTables() async {
    var newTables = await controller.fetchTables();

    setState(() {
      tables = newTables;
    });
  }

  Widget get body => isLoading
      ? CircularProgressIndicator()
      : GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
          ),
          itemCount: tables.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                final detail = context.read<TableModel>();
                detail.addTableId(tables[index].id);
                detail.addTableName(tables[index].name);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TableDetailsPage(),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green[300],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                  child: Text(
                    tables[index].name,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          },
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text('Table Map'),
        ),
        body: Center(child: body));
  }
}
