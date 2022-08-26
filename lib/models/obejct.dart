import 'package:bitsdojo_window_example/models/stock.dart';
import 'package:flutter/cupertino.dart';

import '../objectbox.g.dart';

class ObjectBox extends ChangeNotifier {
  late final Store _store;

  late final Box<Stock> _stockBox;

  ObjectBox._init(this._store) {
    _stockBox = Box<Stock>(_store);
  }

  static Future<ObjectBox> init() async {
    final store = await openStore();

    return ObjectBox._init(store);
  }

  Stock? getUser(int id) => _stockBox.get(id);
  List<Stock >getall() => _stockBox.getAll();
  List<int>? putMany(List<Stock> list) => _stockBox.putMany(list);
  Stream<List<Stock>> getStocks() 
  {
    
    return _stockBox
      .query(Stock_.name.startsWith(''))
      .watch(triggerImmediately: true)
      .map((query) => query.find());}

  int insertStock(Stock stock) => _stockBox.put(stock);

  bool deleteStock(int id) => _stockBox.remove(id);
  deleteAllStock() => _stockBox.removeAll();
}
