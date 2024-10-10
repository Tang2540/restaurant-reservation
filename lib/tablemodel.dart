import 'package:flutter/material.dart';

class TableModel extends ChangeNotifier {
  String _tableID = '';
  int _count = 1;
  //String _date = '';

  String get tableID => _tableID;
  int get count => _count;
  //String get date => _date;
  void addID(item) {
    _tableID = item;
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
