import 'package:bitsdojo_window_example/models/invoice.dart';
import 'package:bitsdojo_window_example/models/mpi.dart';
import 'package:bitsdojo_window_example/models/repair.dart';
import 'package:bitsdojo_window_example/models/spk.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Customer {
  @Id(assignable: true)
  int id;
  String customerName;
  String policeNumber;
  ToOne<Spk> spk = ToOne<Spk>();
  ToOne<Invoice> inv = ToOne<Invoice>();
  ToOne<Repair> repair = ToOne<Repair>();
  ToOne<Mpi> mpi = ToOne<Mpi>();

  Customer({
    this.id = 0,
    required this.customerName,
    required this.policeNumber,
  });
 
}
