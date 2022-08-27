import 'package:objectbox/objectbox.dart';

@Entity()
class Supplier {
  @Id(assignable: true)
  int id;
  String supplier;

  String desc;
  int count;
  String date;
  double totalPrice;
  String supplierHistory;

  Supplier({
    this.id = 0,
    required this.date,
    required this.supplierHistory,
    required this.supplier,
    required this.desc,
    required this.count,
    required this.totalPrice,
  });
}
