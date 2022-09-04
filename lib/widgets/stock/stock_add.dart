import 'dart:convert';

import 'package:bitsdojo_window_example/provider/triger.dart';
import 'package:dropdownfield2/dropdownfield2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../models/stock.dart';

class AddPartName extends StatelessWidget {
  const AddPartName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String p = '';
    String n = '';
    String d = '';

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
                  title: const Text("Insert Sperpate"),
                  content: IntrinsicHeight(
                    child: SizedBox(
                      width: 500,
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: TextFormField(
                                onChanged: (val) {
                                  p = val.toString();
                                },
                                maxLines: 1,
                                decoration: InputDecoration(
                                  hintText: 'Part Name',
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
                                  n = val.toString();
                                },
                                maxLines: 1,
                                decoration: InputDecoration(
                                  hintText: 'Name',
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
                                  d = val.toString();
                                },
                                maxLines: 3,
                                decoration: InputDecoration(
                                  hintText: 'Description',
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
                        if ((p.isNotEmpty || d.isNotEmpty || n.isNotEmpty)) {
                          Stock stock = Stock(
                              lastPrice: 0,
                             
                              partname: p,
                              name: n,
                              desc: d,
                              count: 0,
                              totalPrice: 0);
                          // for (var i = 0; i < 10000; i++) {
                          // stock.name = 'id$i';
                          //  stock.partname = 'part$i';
                          // stock.id = i;
                          objectBox.insertStock(stock);
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
        label: const Text('Add Part Name'));
  }
}
