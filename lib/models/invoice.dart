import 'package:bitsdojo_window_example/models/realization.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Invoice {
  @Id(assignable: true)
  int id;
  String invId;
  double saldo;
  ToOne<Realization> realization = ToOne<Realization>();
//  Map<String,dynamic> rincianPembayaran;
  Invoice({
    this.id = 0,
    required this.invId,
    required this.saldo,
    // required this.rincianPembayaran,
  });
}
