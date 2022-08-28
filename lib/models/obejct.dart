import 'package:bitsdojo_window_example/models/stock.dart';
import 'package:bitsdojo_window_example/models/supplier.dart';
import 'package:flutter/cupertino.dart';

import '../objectbox.g.dart';

class ObjectBox extends ChangeNotifier {
  late final Store _store;

  late final Box<Stock> _stockBox;
  late final Box<Supplier> _supplierBox;

  ObjectBox._init(this._store) {
    _stockBox = Box<Stock>(_store);
    _supplierBox = Box<Supplier>(_store);
  }

  static Future<ObjectBox> init() async {
    final store = await openStore();

    return ObjectBox._init(store);
  }

  ///Supplier
  Stream<List<Supplier>> getSuppliers() {
    return _supplierBox
        .query()
        .watch(triggerImmediately: true)
        .map((query) => query.find());
  }
  int insertSupplier(Supplier stock) => _supplierBox.put(stock);

  bool deleteSupplier(int id) => _supplierBox.remove(id);

  deleteAllSupplier() => _supplierBox.removeAll();
  deleteAllStock() => _stockBox.removeAll();



  ///Stock
  List<Stock> getall() => _stockBox.getAll();

  Stream<List<Stock>> getStocks() {
    return _stockBox
        .query(Stock_.name.startsWith(''))
        .watch(triggerImmediately: true)
        .map((query) => query.find());
  }

  int insertStock(Stock stock) => _stockBox.put(stock);

  bool deleteStock(int id) => _stockBox.remove(id);
}
