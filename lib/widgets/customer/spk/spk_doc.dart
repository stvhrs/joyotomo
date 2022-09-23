import 'package:bitsdojo_window_example/widgets/kop.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/customer.dart';

class SpkDoc extends StatefulWidget {
  final Customer customer;
  const SpkDoc({super.key, required this.customer});

  @override
  State<SpkDoc> createState() => _SpkDocState();
}

class _SpkDocState extends State<SpkDoc> {
  TextEditingController dateinput = TextEditingController();
  //text editing controller for text field

  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Material(
            child: Container(
                padding: EdgeInsets.all(20),
                height: MediaQuery.of(context).size.width * 1.4142,
                width: MediaQuery.of(context).size.width,
                child: Hero(
                    tag: widget.customer,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Kop(),
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                  margin: EdgeInsets.only(top: 10),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black, width: 2),
                                      color: Colors.grey.shade100),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            'Perintah Bengkel: ${widget.customer.csId}'),
                                        TextFormField(initialValue: 'Catatan'),
                                        TextFormField(
                                            initialValue:
                                                widget.customer.customerName),
                                        TextFormField(
                                            initialValue:
                                                widget.customer.namaKendaraan),
                                        TextFormField(
                                          initialValue:
                                              widget.customer.policeNumber,
                                        ),
                                        TextFormField(
                                          initialValue: widget.customer.alamat,
                                        ),
                                        TextFormField(
                                          initialValue: 'Analaisa',
                                        ),
                                        TextFormField(
                                          initialValue: 'keluhan Konsumen',
                                        ),
                                        TextFormField(
                                            initialValue: 'namamekanik'),
                                        TextFormField(
                                            initialValue: 'namameadvisor'),
                                        TextFormField(
                                          initialValue: 'nama inspektor',
                                        ),
                                        TextFormField(
                                          initialValue: 'estimasiSelesai',
                                        ),
                                        TextFormField(
                                          initialValue: 'estimasi biyaya',
                                        ),
                                        TextField(
                                          controller:
                                              dateinput, //editing controller of this TextField
                                          decoration: InputDecoration(
                                              icon: Icon(Icons
                                                  .calendar_today), //icon of text field
                                              labelText:
                                                  "Enter Date" //label text of field
                                              ),
                                          readOnly:
                                              true, //set it true, so that user will not able to edit text
                                          onTap: () async {
                                            DateTime? pickedDate =
                                                await showDatePicker(locale:Localizations.localeOf(context),
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(
                                                        2022), //DateTime.now() - not to allow to choose before today.
                                                    lastDate: DateTime(2101));

                                            if (pickedDate != null) {
                                              print(
                                                  pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                              String formattedDate =
                                                  DateFormat('dd/MM/yyyy')
                                                      .format(pickedDate);
                                              print(
                                                  formattedDate); //formatted date output using intl package =>  2021-03-16
                                              //you can implement different kind of Date Format here according to your requirement

                                              setState(() {
                                                dateinput.text =
                                                    formattedDate; //set output date to TextField value.
                                              });
                                            } else {
                                              print("Date is not selected");
                                            }
                                          },
                                        )
                                      ])))
                        ])))));
  }
}
