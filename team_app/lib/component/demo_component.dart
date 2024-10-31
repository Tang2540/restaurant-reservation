import 'package:flutter/material.dart';
import 'package:team_app/fooddetailmodel.dart';
import 'package:team_app/pages/fooddetail.dart';
import 'package:provider/provider.dart';

class CardData {
  const CardData({required this.name});

  final String name;
}

class DetailData {
  String dish;
  int amount;

  DetailData({required this.dish, required this.amount});
}

class CardWidget extends StatefulWidget {
  const CardWidget({Key? key, required this.cardData}) : super(key: key);

  final CardData cardData;

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }

  void _showSnackBar() {
    // Dismiss any existing SnackBar
    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    // Show new SnackBar with updated counter
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Confirm your order"),
        action: SnackBarAction(
          label: 'Confirm',
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => FoodDetailPage()));
          },
        ),
        duration: Duration(days: 365), // Set a very long duration
        behavior: SnackBarBehavior.fixed, // Make it stay at the bottom
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50.0, child: Icon(Icons.local_dining)),
          const SizedBox(width: 20.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${widget.cardData.name}'),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    Text('Amount'),
                    TextButton(
                      onPressed: () {
                        _decrementCounter();
                      },
                      child: const Icon(Icons.remove_circle),
                    ),
                    Text(
                      '$_counter',
                    ),
                    TextButton(
                      onPressed: () {
                        _incrementCounter();
                      },
                      child: const Icon(Icons.add_circle),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                    onPressed: () {
                      final order = context.read<FoodDetailModel>();
                      order.add(widget.cardData.name, _counter);
                      _showSnackBar();
                    },
                    label: const Text('Select'))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
