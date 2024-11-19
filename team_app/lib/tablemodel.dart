import 'package:flutter/material.dart';

class TableModel extends ChangeNotifier {
  int _count = 1;
  int _tableId = 0;
  String _tableName = "";
  List<dynamic> _dates = [];

  int get count => _count;
  int get tableId => _tableId;
  String get tableName => _tableName;
  List<dynamic> get dates => _dates;

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

  void addTableId(int id) {
    print('Setting tableId to: $id');
    _tableId = id;
    notifyListeners();
  }

  void addTableName(String name) {
    _tableName = name;
    notifyListeners();
  }

  void addDate(List<dynamic> newDates) {
    _dates = newDates;
    notifyListeners();
  }

  void clearDates() {
    _dates.clear();
    notifyListeners();
  }
}
