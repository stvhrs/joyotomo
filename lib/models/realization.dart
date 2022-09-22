import 'package:bitsdojo_window_example/models/mpi.dart';
import 'package:bitsdojo_window_example/models/mpi/mpiItem.dart';
import 'package:bitsdojo_window_example/models/stock.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Realization {
  @Id(assignable: true)
  int id;
  String rlId;
  int selesai;
  double biyaya;
  final mpiItems=ToMany<MpiItem>();
  final stockItems=ToMany<Stock>();
  bool done;

  Realization({
    this.id = 0,
    required this.rlId,
    // required this.mpiCost,
    // required this.partCost,
    required this.selesai,
    required this.biyaya,
    required this.done,
  });
}
