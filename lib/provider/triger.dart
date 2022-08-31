import 'dart:convert';

import 'package:bitsdojo_window_example/models/supplier.dart';
import 'package:flutter/cupertino.dart';

import '../models/stock.dart';

class Trigger extends ChangeNotifier {
   List<Stock> listSelectedStock=[];
 List<Supplier> listSelectedSupplier=[];
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
  selectListSupplier(List<Supplier> suppliers, bool listen) {
    listSelectedSupplier = suppliers;
    if (listen) notifyListeners();
  }
  selectListStock(List<Stock> stocks, bool listen) {
    listSelectedStock = stocks;
    if (listen) notifyListeners();
  }
}
