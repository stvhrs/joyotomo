import 'dart:convert';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

import '../main.dart';
import '../models/stock.dart';

class AddPartName extends StatelessWidget {
  const AddPartName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String p = '';
    String n = '';
    String d = '';
    return ElevatedButton.icon(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(Color.fromARGB(255, 79, 117, 134))),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  actionsPadding: EdgeInsets.only(right: 15, bottom: 15),
                  title: Text("Insert Sperpate"),
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
                              stockHistory: json.encode([
                                {},
                              ]),
                              partname: p,
                              name: n,
                              desc: d,
                              count: 0,
                              totalPrice: 0);
                          objectBox.insertStock(stock);
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text("Insert"),
                    ),
                  ],
                );
              });
        },
        icon: Icon(Icons.add),
        label: Text('Add Part Name'));
  }
}
