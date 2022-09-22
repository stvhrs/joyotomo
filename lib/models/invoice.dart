import 'package:objectbox/objectbox.dart';

@Entity()
class Invoice {
  @Id(assignable: true)
  int id;
  String name;
  String partname;
  String desc;

  int count;
  double lastPrice;
  double totalPrice;

  Invoice({
    this.id = 0,
    required this.partname,
    required this.name,
    required this.desc,
    required this.lastPrice,
    required this.count,
    required this.totalPrice,
  });
}
