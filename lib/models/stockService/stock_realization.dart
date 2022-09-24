import 'package:bitsdojo_window_example/models/stock.dart';

import 'package:objectbox/objectbox.dart';

@Entity()
class StockRalization {
  @Id(assignable: true)
  int id;
  String name;
  String partname;
  String desc;
  ToOne<Stock> realization = ToOne<Stock>();
  int count;
double price;
  double servicePrice;
  double toalPrice;
  

  StockRalization({
    this.id = 0,
   
    required this.partname,
    required this.name,
    required this.desc,
    required this.price,
    required this.count,
    required this.servicePrice,
    required this.toalPrice,
    // required this.stockRalizationHistory,
  });
  // factory StockRalization.fromMap(Map<String, dynamic> map) {
  //   return StockRalization(
  //     name: map['name'],
  //     desc: map['desc'],
  //     stockRalization: map['stockRalization'],
  //     price: map['price'],
  //     servicePrice: map['servicePrice'],
  //     stockRalizationHistory: map['stockRalizationHistory'],
  //   );
  // }
  // static Map<String, dynamic> toMap(StockRalization stockRalization) {
  //   return {
  //     'name': stockRalization.name,
  //     'desc': stockRalization.desc,
  //     'stockRalization': stockRalization.stockRalization,
  //     'price': stockRalization.price,
  //     'servicePrice': stockRalization.servicePrice,
  //     'stockRalizationHistory': stockRalization.stockRalizationHistory,
  //   };
  // }
}
