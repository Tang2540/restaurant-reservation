import 'package:flutter/material.dart';

class RestaurantMapPage extends StatefulWidget {
  @override
  _RestaurantMapPageState createState() => _RestaurantMapPageState();
}

class _RestaurantMapPageState extends State<RestaurantMapPage> {
  final _formKey = GlobalKey<FormState>();
  String restaurantName = '';
  String foodType = '';
  String address = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Restaurant'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Stack(
        children: [
          // แสดงรูปแผนที่
          
          // ปักหมุดร้านที่ตำแหน่งต่างๆในแผนที่
          Positioned(
            left: 150,
            top: 200,
            child: GestureDetector(
              onTap: () {
                // เมื่อกดตำแหน่งร้าน A
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RestaurantDetailsPage(
                      restaurantName: 'Restaurant A',
                    ),
                  ),
                );
              },
              child: Icon(Icons.location_pin, color: Colors.red, size: 40),
            ),
          ),
          Positioned(
            left: 300,
            top: 400,
            child: GestureDetector(
              onTap: () {
                // เมื่อกดตำแหน่งร้าน B
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RestaurantDetailsPage(
                      restaurantName: 'Restaurant B',
                    ),
                  ),
                );
              },
              child: Icon(Icons.location_pin, color: Colors.red, size: 40),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Search Restaurant',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Restaurant Name'),
                        onChanged: (value) {
                          restaurantName = value;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Food Type'),
                        onChanged: (value) {
                          foodType = value;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Address'),
                        onChanged: (value) {
                          address = value;
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {

                        },
                        child: Text('Search'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RestaurantDetailsPage extends StatelessWidget {
  final String restaurantName;

  const RestaurantDetailsPage({Key? key, required this.restaurantName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$restaurantName Details'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant, size: 100),
            SizedBox(height: 20),
            Text(
              restaurantName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: RestaurantMapPage(),
  ));
}
