import 'dart:developer';
import 'dart:ffi';

import 'package:bitsdojo_window_example/helper/currency.dart';
import 'package:bitsdojo_window_example/main.dart';
import 'package:bitsdojo_window_example/widgets/kop.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../models/customer.dart';
import '../../../models/spk.dart';

class SpkDoc extends StatefulWidget {
  final Customer customer;
  const SpkDoc({super.key, required this.customer});

  @override
  State<SpkDoc> createState() => _SpkDocState();
}

class _SpkDocState extends State<SpkDoc> {
  TextEditingController dateinput = TextEditingController();
  late Spk spk;
  @override
  void initState() {
    super.initState();
    spk = widget.customer.spk.target!;
    dateinput.text =spk.date;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          padding: const EdgeInsets.all(20),
          height: MediaQuery.of(context).size.width * 1.4142,
          width: MediaQuery.of(context).size.width,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Kop(),
            GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        color: Colors.grey.shade100),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Perintah Bengkel: ${spk.jtId}'),
                          Row(
                            children: [
                              IntrinsicWidth(
                                  child: TextFormField(
                                      onChanged: (v) {
                                        setState(() {});
                                        spk.catatan = v;
                                      },
                                      initialValue: spk.catatan)),
                              IntrinsicWidth(
                                child: TextFormField(
                                    onChanged: (v) {
                                      setState(() {});
                                      widget.customer.customerName = v;
                                    },
                                    initialValue: widget.customer.customerName),
                              ),
                            ],
                          ),
                          TextFormField(
                              onChanged: (v) {
                                setState(() {});
                                widget.customer.namaKendaraan = v;
                              },
                              initialValue: widget.customer.namaKendaraan),
                          TextFormField(
                            onChanged: (v) {
                              setState(() {});
                              widget.customer.policeNumber = v;
                            },
                            initialValue: widget.customer.policeNumber,
                          ),
                          TextFormField(
                            onChanged: (v) {
                              setState(() {});
                              widget.customer.alamat = v;
                            },
                            initialValue: widget.customer.alamat,
                          ),
                          TextFormField(
                            onChanged: (v) {
                              setState(() {});
                              spk.analisa = v;
                            },
                            initialValue: spk.analisa,
                          ),
                          TextFormField(
                            onChanged: (v) {
                              setState(() {});
                              spk.keluhanKonsumen = v;
                            },
                            initialValue: spk.keluhanKonsumen,
                          ),
                          TextFormField(
                              onChanged: (v) {
                                setState(() {});
                                spk.namaKendaraan = v;
                              },
                              initialValue: spk.namaKendaraan),
                          TextFormField(
                              onChanged: (v) {
                                setState(() {});
                                spk.namaAdvisor = v;
                              },
                              initialValue: spk.namaAdvisor),
                          TextFormField(
                            onChanged: (v) {
                              setState(() {});
                              spk.namaMekanik = v;
                            },
                            initialValue: spk.namaMekanik,
                          ),
                          TextFormField(
                            onChanged: (v) {
                              setState(() {});
                              spk.estimasiSelesai = v;
                            },
                            initialValue: spk.estimasiSelesai,
                          ),
                          TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CurrencyInputFormatter()
                            ],
                            onChanged: (v) {
                              setState(() {});
                              spk.estimasiBiyaya = NumberFormat.currency(
                                      locale: 'id_ID', symbol: 'Rp ')
                                  .parse(v)
                                  .toDouble();
                            },
                            initialValue: spk.estimasiBiyaya.toString(),
                          ),
                          TextFormField(
                           
                            controller: dateinput,
                            //editing controller of this TextField
                            decoration: const InputDecoration(
                                icon: Icon(
                                    Icons.calendar_today), //icon of text field
                                labelText: "Enter Date" //label text of field
                                ),

                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  locale: Localizations.localeOf(context),
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(
                                      2022), //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2101));

                              if (pickedDate != null) {
                                print(
                                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                String formattedDate =
                                    DateFormat('dd/MM/yyyy').format(pickedDate);
                                print(
                                    formattedDate); //formatted date output using intl package =>  2021-03-16
                                //you can implement different kind of Date Format here according to your requirement

                                setState(() {
                                  dateinput.text =
                                      formattedDate; //set output date to TextField value.
                                  spk.date = dateinput.text;
                                });
                              } else {
                                print("Date is not selected");
                              }
                            },
                          ),
                          ElevatedButton(
                              onPressed: () {
                      widget.customer.spk.target=Spk(jtId: spk.jtId, customerName: spk.customerName, policeNumber: spk.policeNumber,
                       namaKendaraan:spk.namaKendaraan, date: spk.date, alamat:spk.alamat, analisa: spk.analisa, keluhanKonsumen: spk.keluhanKonsumen, catatan:spk.catatan,
                        namaMekanik: spk.namaMekanik, estimasiBiyaya:spk.estimasiBiyaya, estimasiSelesai: spk.estimasiSelesai, namaAdvisor: spk.namaAdvisor,
                         namaInspeektor:spk.namaInspeektor);
                       
                                objectBox.insertCustomer(widget.customer);
                              },
                              child: Text('df'))
                        ])))
          ])),
    );
  }
}
