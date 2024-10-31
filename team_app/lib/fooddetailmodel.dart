import 'package:flutter/material.dart';

class DetailData {
  String dish;
  int amount;

  DetailData({required this.dish, required this.amount});
}

class FoodDetailModel extends ChangeNotifier {
  List<DetailData> _dataList = [];

  List<DetailData> get dataList => _dataList;

  void add(dishInput, amountInput) {
    _dataList.add(DetailData(dish: dishInput, amount: amountInput));
    notifyListeners();
  }
}
