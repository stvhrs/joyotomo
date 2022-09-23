import 'package:bitsdojo_window_example/models/customer.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../models/stock.dart';

class CustomerAdd extends StatelessWidget {
  final int csId;
  const CustomerAdd({Key? key, required this.csId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String namaCustomer = '';
    String nomorPolisi = '';
    String alamat = '';
    String namaKendaraan='';

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
                              decoration: InputDecoration(
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
                          ),  Container(
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
                        if ((namaCustomer.isNotEmpty || nomorPolisi.isNotEmpty || namaKendaraan.isNotEmpty)) {
                          Customer stock = Customer(
                              alamat: alamat,
                              customerName: namaCustomer,
                              policeNumber: nomorPolisi,
                              namaKendaraan: namaKendaraan,
                              csId: 'CS/JT/000000'.replaceRange(12-csId.toString().length, 12, csId.toString()) );
                          // for (var i = 0; i < 10000; i++) {
                          // stock.name = 'id$i';
                          //  stock.partname = 'part$i';
                          // stock.id = i;
                          objectBox.insertCustomer(stock);
                          // }
                          //  objectBox.insertStock(stock);
                          //  objectBox.deleteAllStock();
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
