import 'package:flutter/material.dart';

class FoodData {
  const FoodData({required this.dish, required this.amount});

  final String dish;
  final int amount;
}

class FoodCardWidget extends StatelessWidget {
  const FoodCardWidget({Key? key, required this.foodData}) : super(key: key);

  final FoodData foodData;

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
                Text('${foodData.dish}'),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    Icon(Icons.supervisor_account),
                    Text(
                      '${foodData.amount}',
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
