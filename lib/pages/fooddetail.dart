import 'package:flutter/material.dart';
import 'package:team_app/component/detail_card.dart';
import 'package:team_app/fooddetailmodel.dart';
import 'package:provider/provider.dart';

class FoodDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<FoodDetailModel>(builder: (context, food, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Reserve Tables'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Column(children: [
          Expanded(
              child: ListView.separated(
                  padding: EdgeInsets.all(8.0),
                  itemCount: food.dataList.length,
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemBuilder: (context, index) {
                    return Container(
                        height: 200,
                        color: Color.fromARGB(255, 103, 250, 81),
                        child: Center(
                            child: FoodCardWidget(
                                foodData: FoodData(
                                    dish: food.dataList[index].dish,
                                    amount: food.dataList[index].amount))));
                  })),
          Padding(
              padding: EdgeInsets.all(25.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Color.fromARGB(255, 103, 250, 81), // Background color
                  foregroundColor: Colors.black, // Text color
                ),
                child: Text('Book Now'),
              ))
        ]),
      );
    });
  }
}
