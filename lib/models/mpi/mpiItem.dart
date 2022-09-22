import 'package:objectbox/objectbox.dart';

@Entity()
class MpiItem {
  @Id(assignable: true)
  int id;
  String category;
  String name;
  double price;
  String remark;
  int attention;

  // Map<String, dynamic> ftrBrakes;

  MpiItem({
    this.id = 0,
    required this.category,
    required this.name,
    required this.attention,
    required this.price,
    required this.remark
    // required this.ftrBrakes,
  });
}
