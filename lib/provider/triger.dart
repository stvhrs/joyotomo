import 'dart:convert';

import 'package:bitsdojo_window_example/models/supplier.dart';
import 'package:flutter/cupertino.dart';

import '../models/stock.dart';

class Trigger extends ChangeNotifier {
  late Stock selectedStock;
  late Supplier selectedSupplier;

  select(Stock stock, bool listen) {
    selectedStock = stock;
    if (listen) notifyListeners();
  }
   selectSupplier(Supplier supplier, bool listen) {
    selectedSupplier = supplier;
    if (listen) notifyListeners();
  }
}
