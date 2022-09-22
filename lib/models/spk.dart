import 'package:objectbox/objectbox.dart';

@Entity()
class Spk {
 @Id(assignable: true)
  int id;
  String jtId;
  String customerName;
  String policeNumber;
  String namaKendaraan;
  String date;
  String alamat;
  String analisa;
  String keluhanKonsumen;
  String catatan;
  String namaMekanik;
  double estimasiBiyaya;
  String estimasiSelesai;
  String namaInspeektor;
  String namaAdvisor;


 Spk(
      {this.id = 0,
      required this.jtId,
      required this.customerName,
      required this.policeNumber,
      required this.namaKendaraan,
      required this.date,
      required this.alamat,
      required this.analisa,
      required this.keluhanKonsumen,
      required this.catatan,
      required this.namaMekanik,
      required this.estimasiBiyaya,
      required this.estimasiSelesai,
      required this.namaAdvisor,
      required this.namaInspeektor,
      });
}
