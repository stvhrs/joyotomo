import 'package:bitsdojo_window_example/models/invoice.dart';
import 'package:bitsdojo_window_example/models/mpi.dart';
import 'package:bitsdojo_window_example/models/realization.dart';
import 'package:bitsdojo_window_example/models/spk.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Customer {
  @Id(assignable: true)
  int id;
  String csId;
  String customerName;
  String policeNumber;
  String namaKendaraan;
  String alamat;

  ToOne<Spk> spk = ToOne<Spk>();
  ToOne<Invoice> inv = ToOne<Invoice>();
  ToOne<Realization> realization = ToOne<Realization>();
  ToOne<Mpi> mpi = ToOne<Mpi>();

  Customer(
      {this.id = 0,
      required this.csId,
      required this.customerName,
      required this.policeNumber,
      required this.namaKendaraan,
      required this.alamat});
}
