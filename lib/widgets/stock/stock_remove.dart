import 'dart:convert';
import 'dart:developer';

import 'package:bitsdojo_window_example/main.dart';
import 'package:bitsdojo_window_example/provider/triger.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/stock.dart';

class StockRemove extends StatefulWidget {
  const StockRemove({Key? key}) : super(key: key);

  @override
  State<StockRemove> createState() => _StockRemoveState();
}

class _StockRemoveState extends State<StockRemove> {
  int _reduce = 1;
  String _reduceDes = '';
  @override
  void dispose() {
    log('diso');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Stock stock = Provider.of<Trigger>(context, listen: false).selectedStock;
    return Row(
      children: [
        Spacer(),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: ElevatedButton.icon(
              style: ButtonStyle(
                  alignment: Alignment.centerRight,
                  backgroundColor: MaterialStateProperty.all(Colors.white)),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                          actionsPadding:
                              const EdgeInsets.only(right: 15, bottom: 15),
                          title: const Text("Reduce Stock"),
                          content: StatefulBuilder(
                            builder:
                                (BuildContext context, StateSetter setState) =>
                                    IntrinsicHeight(
                              child: SizedBox(
                                width: 500,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                if (_reduce > 1) {
                                                  _reduce = _reduce - 1;
                                                }
                                              });
                                            },
                                            icon: Icon(Icons.remove_circle)),
                                        Text(_reduce.toString()),
                                        IconButton(
                                            onPressed: () {
                                              if (_reduce < stock.count) {
                                                setState(() {
                                                  _reduce = _reduce + 1;
                                                });
                                              }
                                            },
                                            icon: Icon(Icons.add_circle)),
                                      ],
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 20),
                                      child: TextFormField(
                                          onChanged: (val) {
                                            _reduceDes = val;
                                          },
                                          maxLines: 3,
                                          decoration: InputDecoration(
                                            hintText: 'Description',
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    left: 10,
                                                    top: 10,
                                                    bottom: 10),
                                            fillColor: Colors.white,
                                            hintStyle: TextStyle(
                                                color: Colors.grey.shade600,
                                                fontSize: 15,
                                                height: 2),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                              borderSide: BorderSide(
                                                  color: Colors.grey.shade300),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                              borderSide: BorderSide(
                                                  color: Colors.grey.shade300),
                                            ),
                                          )),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          actions: <Widget>[
                            ElevatedButton(
                              onPressed: () {
                                List history = json.decode(stock.stockHistory);
                                history.add({
                                  'date': DateTime.now().toIso8601String(),
                                  'supplier': _reduceDes,
                                  'count': - _reduce,
                                  'totalPrice':-stock.lastPrice*_reduce,
                                  'price':-stock.lastPrice,
                                });
                                stock.count = stock.count - _reduce;
                                stock.stockHistory = json.encode(history);
                                objectBox.insertStock(stock);
                                Navigator.of(context).pop();
                              },
                              child: const Text("Reduce"),
                            ),
                          ]);
                    }).then((value) {
                  _reduce = 1;
                  _reduceDes = '';
                });
              },
              icon: Icon(
                Icons.warning_amber_rounded,
                color: Colors.red,
              ),
              label: Text(
                'Accident',
                style: TextStyle(color: Colors.red),
              )),
        ),
      ],
    );
  }
}
