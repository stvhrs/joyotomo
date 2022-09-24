import 'package:bitsdojo_window_example/models/customer.dart';
import 'package:bitsdojo_window_example/models/invoice/payment.dart';
import 'package:bitsdojo_window_example/models/mpi/mpiItem.dart';
import 'package:bitsdojo_window_example/models/realization.dart';
import 'package:bitsdojo_window_example/models/spk.dart';
import 'package:bitsdojo_window_example/models/stock.dart';
import 'package:bitsdojo_window_example/models/stockService/stock_realization.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../models/invoice.dart';
import '../../models/mpi.dart';
import '../../objectbox.g.dart';

class CustomerAdd extends StatelessWidget {
  final int csId;
  const CustomerAdd({Key? key, required this.csId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String namaCustomer = '';
    String nomorPolisi = '';
    String alamat = '';
    String namaKendaraan = '';

    return ElevatedButton.icon(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                const Color.fromARGB(255, 79, 117, 134))),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  actionsPadding: const EdgeInsets.only(right: 15, bottom: 15),
                  title: const Text("Insert Customer"),
                  content: IntrinsicHeight(
                    child: SizedBox(
                      width: 500,
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'Nama Customer',
                              ),
                              onChanged: (val) {
                                namaCustomer = val.toString();
                              },
                              maxLines: 1,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: TextFormField(
                                onChanged: (val) {
                                  nomorPolisi = val.toString();
                                },
                                maxLines: 1,
                                decoration: InputDecoration(
                                  hintText: 'Nomor Polisi',
                                  contentPadding: const EdgeInsets.only(
                                      left: 10, top: 10, bottom: 10),
                                  fillColor: Colors.white,
                                  hintStyle: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 15,
                                      height: 2),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7),
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade300),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7),
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade300),
                                  ),
                                )),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: TextFormField(
                                onChanged: (val) {
                                  namaKendaraan = val.toString();
                                },
                                maxLines: 1,
                                decoration: InputDecoration(
                                  hintText: 'Nama Kendaraan',
                                  contentPadding: const EdgeInsets.only(
                                      left: 10, top: 10, bottom: 10),
                                  fillColor: Colors.white,
                                  hintStyle: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 15,
                                      height: 2),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7),
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade300),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7),
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade300),
                                  ),
                                )),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: TextFormField(
                                onChanged: (val) {
                                  alamat = val.toString();
                                },
                                maxLines: 3,
                                decoration: InputDecoration(
                                  hintText: 'Alamat',
                                  contentPadding: const EdgeInsets.only(
                                      left: 10, top: 10, bottom: 10),
                                  fillColor: Colors.white,
                                  hintStyle: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 15,
                                      height: 2),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7),
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade300),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7),
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade300),
                                  ),
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                  actions: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        if ((namaCustomer.isNotEmpty ||
                            nomorPolisi.isNotEmpty ||
                            namaKendaraan.isNotEmpty)) {
                          Customer customer = Customer(
                              alamat: alamat,
                              customerName: namaCustomer,
                              policeNumber: nomorPolisi,
                              namaKendaraan: namaKendaraan,
                              csId: 'CS/JT/000000'.replaceRange(
                                  12 - csId.toString().length,
                                  12,
                                  csId.toString()));

                          customer.spk.target = Spk(
                              jtId: 'SPK/JT/000000'.replaceRange(
                                  12 - csId.toString().length,
                                  12,
                                  csId.toString()),
                              customerName: namaCustomer,
                              policeNumber: nomorPolisi,
                              namaKendaraan: namaKendaraan,
                              date: '3/2/2002',
                              alamat: alamat,
                              analisa: 'analisa',
                              keluhanKonsumen: 'keluhanKonsumen',
                              catatan: 'catatan',
                              namaMekanik: 'namaMekanik',
                              estimasiBiyaya: 99.99,
                              estimasiSelesai: 'l',
                              namaAdvisor: 'namaAdvisor',
                              namaInspeektor: 'namaInspeektor');
                          customer.mpi.target = Mpi(
                            mpiId: 'MPI/JT/000000'.replaceRange(
                                12 - csId.toString().length,
                                12,
                                csId.toString()),
                          );
                          customer.mpi.target!.items !=
                              [
                                MpiItem(
                                    category: 'under',
                                    name: 'Vechicale',
                                    attention: 0,
                                    price: 0,
                                    remark: 'remark')
                              ];
                          customer.realization.target = Realization(
                              rlId: 'RLT/JT/000000'.replaceRange(
                                  12 - csId.toString().length,
                                  12,
                                  csId.toString()),
                              selesai: 0,
                              biyaya: 0,
                              done: false);
                          customer.realization.target!.mpiItems !=
                              [
                                MpiItem(
                                    category: 'under',
                                    name: 'Vechicale2',
                                    attention: 1,
                                    price: 100,
                                    remark: 'remark')
                              ];
                          customer.realization.target!.stockItems !=
                              [
                                StockRalization(
                                    partname: 'etst',
                                    name: 'name',
                                    desc: ' desc',
                                    price: 1000,
                                    count: 3,
                                    servicePrice: 100,
                                    toalPrice: 1100)
                              ];
                          customer.inv.target = Invoice(
                              invId: 'INV/JT/000000'.replaceRange(
                                  12 - csId.toString().length,
                                  12,
                                  csId.toString()),
                              saldo: 0);
                          customer.inv.target!.realization =
                              customer.realization;
                          customer.inv.target!.payments.add(Payment(
                              pay: 123,
                              name: 'name',
                              date: ' date',
                              keterangan: 'keterangan'));
                          objectBox.insertCustomer(customer);

                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text("Insert"),
                    ),
                  ],
                );
              });
        },
        icon: const Icon(Icons.add),
        label: const Text('Add'));
  }
}
