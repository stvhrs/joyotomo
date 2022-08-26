import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../models/stock.dart';

class Trigger extends ChangeNotifier {
  late Stock selectedStock;

  select(Stock stock, bool listen) {
    selectedStock = stock;
    if (listen) notifyListeners();
  }
}
