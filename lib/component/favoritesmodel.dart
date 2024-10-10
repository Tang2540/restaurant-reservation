import 'package:flutter/material.dart';

class FavoritesModel extends ChangeNotifier {
  List<Map<String, String>> _favoriteRestaurants = [];

  List<Map<String, String>> get favoriteRestaurants => _favoriteRestaurants;

  void addFavorite(String name, String comment) {
    _favoriteRestaurants.add({'name': name, 'comment': comment});
    notifyListeners();
  }

  void removeFavorite(String name) {
    _favoriteRestaurants.removeWhere((item) => item['name'] == name);
    notifyListeners();
  }
}
