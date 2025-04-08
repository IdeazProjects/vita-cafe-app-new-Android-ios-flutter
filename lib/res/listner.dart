import 'package:flutter/material.dart';

import '../model.dart/itemslocalmodel.dart';
class ItemList with ChangeNotifier {
  List<Item> _storeitems = [];

  List<Item> get storeitems => _storeitems;

  void storeincrementId(int index) {
    _storeitems[index].productquantity++;
    notifyListeners();
  }

  void storedecrementId(int index) {
    if (_storeitems[index].productquantity > 0) {
      _storeitems[index].productquantity--;
    }
    notifyListeners();
  }

  storegetItemsByProductId(String targetProductId) {}
}
