import 'package:flutter/material.dart';

class TableModel extends ChangeNotifier {
  String _tableID = '';
  int _count = 1;
  List _dates = [];

  String get tableID => _tableID;
  int get count => _count;
  List get dates => _dates;
  //String get date => _date;
  void addID(item) {
    _tableID = item;
    notifyListeners();
  }

  void addDate(item) {
    _dates = item;
    notifyListeners();
  }

  void increment() {
    _count++;
    notifyListeners();
  }

  void decrement() {
    if (_count > 1) {
      _count--;
      notifyListeners();
    }
  }
}
