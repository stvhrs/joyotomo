import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:bitsdojo_window_example/main.dart';
import 'package:bitsdojo_window_example/models/stock_history.dart';
import 'package:bitsdojo_window_example/models/supplier.dart';
import 'package:bitsdojo_window_example/models/supplier_history.dart';
import 'package:bitsdojo_window_example/widgets/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:objectbox/src/relations/to_many.dart';
import 'package:provider/provider.dart';

import '../../models/stock.dart';
import '../../provider/triger.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    final oldValueText = oldValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    String newValueText = newValue.text;

    // We manually remove the value we want to remove
    // If oldValueText == newValue.text it means we deleted a non digit number.
    if (oldValueText == newValue.text) {
      newValueText = newValueText.substring(0, newValue.selection.end - 1) +
          newValueText.substring(newValue.selection.end, newValueText.length);
    }

    double value = double.parse(double.parse(newValueText).toStringAsFixed(2));
    final formatter = NumberFormat.currency(locale: "id_ID", symbol: 'Rp ');
    String newText = formatter.format(value / 100);

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }
}

class SupplierAdd extends StatefulWidget {
  @override
  State<SupplierAdd> createState() => _SupplierAddState();
}

class _SupplierAddState extends State<SupplierAdd> {
  String d = '';
  TextEditingController _controller = TextEditingController();
  int jumlahOpsi = 1;

  List<Stock> _updatedStock = [];

  String _supplier = '';

  List<StockHistory> data = [
    StockHistory(supplier: '', date: '', price: 0, count: 1, totalPrice: 0)
  ];

  Widget _buildPartName(int i, BuildContext context) {
    List<Stock> stocks =
        Provider.of<Trigger>(context, listen: false).listSelectedStock;

    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 200,
                  child: DropDownField(
                    inputFormatters: [],
                    required: true,
                    onValueChanged: (val) {
                      if (stocks
                          .map((e) => e.partname)
                          .toList()
                          .contains(val)) {
                        if (_updatedStock.length < i + 1) {
                          _updatedStock.insert(
                              i,
                              stocks.firstWhere(
                                  (element) => element.partname == val));
                        }

                        setState(() {});
                      }
                    },
                    strict: true,
                    labelText: 'PartName',
                    items: stocks.map((e) => e.partname).toList(),
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: 200,
                  child: TextField(
                    onChanged: (value) {
                   
                   
                      if (_updatedStock.isNotEmpty) {
                       
                        _updatedStock[i].totalPrice =NumberFormat.currency(locale: 'id_ID',symbol: 'Rp ').parse(value).toDouble();
                      }
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CurrencyInputFormatter()
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {});
                      if (data[i].count > 1) {
                        setState(() {
                          data[i].count--;
                          // _updatedStock[i].count--;
                        });
                      }
                    },
                    icon: Icon(Icons.remove_circle)),
                Text(data[i].count.toString()),
                IconButton(
                    onPressed: () {
                      setState(() {
                        data[i].count++;
                        // _updatedStock[i].count++;
                      });
                    },
                    icon: Icon(Icons.add_circle)),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    List<Supplier> suppliers =
        Provider.of<Trigger>(context, listen: false).listSelectedSupplier;
    List<Stock> stocks =
        Provider.of<Trigger>(context, listen: false).listSelectedStock;
    List<String> itemsSupplier = [];
    if (suppliers.isNotEmpty) {
      for (Supplier e in suppliers) {
        if (!itemsSupplier.contains(e.supplier)) {
          itemsSupplier.add(e.supplier);
        }
      }
    } else {
      itemsSupplier.add(_supplier);
    }

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: ElevatedButton.icon(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 79, 117, 134))),
          onPressed: stocks.isEmpty
              ? () {}
              : () {
                  if (suppliers.isEmpty) {}
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                            actionsPadding:
                                const EdgeInsets.only(right: 15, bottom: 15),
                            title: const Text("Kulakan"),
                            content: StatefulBuilder(
                              builder: (BuildContext context,
                                      StateSetter setState) =>
                                  IntrinsicHeight(
                                child: SizedBox(
                                  width: 500,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      DropDownField(
                                        required: true,
                                        inputFormatters: [],
                                        strict: true,
                                        controller: _controller,
                                        labelText: 'Supplier',
                                        onValueChanged: (v) {
                                          _supplier = v;
                                        },
                                        items: itemsSupplier,
                                      ),
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 20),
                                        child: TextFormField(
                                            onChanged: (val) {},
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
                                                    color:
                                                        Colors.grey.shade300),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                                borderSide: BorderSide(
                                                    color:
                                                        Colors.grey.shade300),
                                              ),
                                            )),
                                      ),
                                      ...List.generate(
                                          jumlahOpsi,
                                          (index) =>
                                              _buildPartName(index, context)),
                                      Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (jumlahOpsi > 1 &&
                                                      jumlahOpsi ==
                                                          _updatedStock
                                                              .length) {
                                                    _updatedStock.removeAt(
                                                        jumlahOpsi - 1);
                                                    data.removeAt(
                                                        jumlahOpsi - 1);
                                                    jumlahOpsi = jumlahOpsi - 1;
                                                  }
                                                });
                                              },
                                              icon: Icon(Icons.remove_circle)),
                                          // Text(jumlahOpsi.toString()),
                                          IconButton(
                                              onPressed: () {
                                                if (jumlahOpsi ==
                                                    _updatedStock.length) {
                                                  setState(() {
                                                    jumlahOpsi = jumlahOpsi + 1;
                                                    data.add(StockHistory(
                                                        supplier: '',
                                                        date: '',
                                                        price: 0,
                                                        count: 1,
                                                        totalPrice: 0));
                                                  });
                                                }
                                              },
                                              icon: Icon(Icons.add_circle)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                onPressed: () {
                                  _supplier = _controller.text;
                                  Stock tempStock;
                                  Supplier tempSupplier;

                                  if (_supplier != '' &&
                                      _updatedStock.isNotEmpty) {
                                    tempSupplier = Supplier(
                                        date: DateTime.now().toIso8601String(),
                                        supplier: _supplier,
                                        desc: 'desc',
                                        count: 69,
                                        totalPrice: 69);
                                    for (var i = 0;
                                        i < _updatedStock.length;
                                        i++) {
                                      tempStock = _updatedStock[i];
                                      tempStock.count = data[i].count;
                                      tempSupplier.items.add(SupplierHistory(
                                          name: tempStock.name,
                                          partName: tempStock.partname,
                                          count: tempStock.count,
                                          price: tempStock.lastPrice,
                                          totalPrice: tempStock.totalPrice));
                                    }

                                    /// UPDATE STOCK VALUE
                                    for (var i = 0;
                                        i < _updatedStock.length;
                                        i++) {
                                      Stock tempStock;
                                      late StockHistory history;
                                      tempStock = _updatedStock[i];
                                      history = StockHistory(
                                          supplier: _supplier,
                                          date:
                                              DateTime.now().toIso8601String(),
                                          price: data[i].price,
                                          count: data[i].count,
                                          totalPrice: data[i].totalPrice);

                                      tempStock.items.add(history);

                                      tempStock.count = (data[i].count);
                                      tempStock.lastPrice = 200;

                                      objectBox.insertStock(tempStock);
                                    }
                                    objectBox.insertSupplier(tempSupplier);
                                    Navigator.of(context).pop();
                                  }
                                },
                                child: const Text("Reduce"),
                              ),
                            ]);
                      }).then((value) {
                    d = '';
                    jumlahOpsi = 1;
                    _updatedStock = [];
                    _supplier = '';
                    data = [
                      StockHistory(
                          supplier: '',
                          date: '',
                          price: 0,
                          count: 1,
                          totalPrice: 0)
                    ];
                  });
                },
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          label: const Text(
            'Add Supplier',
            style: TextStyle(color: Colors.white),
          )),
    );
  }
}
