

import 'package:bitsdojo_window_example/main.dart';
import 'package:bitsdojo_window_example/models/stock_history.dart';
import 'package:bitsdojo_window_example/models/supplier.dart';
import 'package:bitsdojo_window_example/models/supplier_history.dart';
import 'package:bitsdojo_window_example/helper/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:objectbox/src/relations/to_many.dart';
import 'package:provider/provider.dart';

import '../../helper/currency.dart';
import '../../models/stock.dart';
import '../../provider/triger.dart';


class SupplierAdd extends StatefulWidget {
  @override
  State<SupplierAdd> createState() => _SupplierAddState();
}

class _SupplierAddState extends State<SupplierAdd> {
  String _desc = '';
  String _supplier = '';

  TextEditingController _controller = TextEditingController();
  int jumlahOpsi = 1;

  List<Stock> _updatedStock = [];
  List<StockHistory> _updatedStockHistory = [
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
                        _updatedStock[i].lastPrice = NumberFormat.currency(
                                locale: 'id_ID', symbol: 'Rp ')
                            .parse(value)
                            .toDouble();
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
                      if (_updatedStockHistory[i].count > 1) {
                        setState(() {
                          _updatedStockHistory[i].count--;
                          // _updatedStock[i].count--;
                        });
                      }
                    },
                    icon: Icon(Icons.remove_circle)),
                Text(_updatedStockHistory[i].count.toString()),
                IconButton(
                    onPressed: () {
                      setState(() {
                        _updatedStockHistory[i].count++;
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
                                                    _updatedStockHistory
                                                        .removeAt(
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
                                                    _updatedStockHistory.add(
                                                        StockHistory(
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
                                  int itemsCount = 0;
                                  double itemsTotalPrice = 0;

                                  if (_supplier != '' &&
                                      _updatedStock.isNotEmpty) {
                                    tempSupplier = Supplier(
                                        date: DateTime.now().toIso8601String(),
                                        supplier: _supplier,
                                        desc: _desc,
                                        count: itemsCount,
                                        totalPrice: itemsTotalPrice);

                                    for (var i = 0;
                                        i < _updatedStock.length;
                                        i++) {
                                      tempStock = _updatedStock[i];
                                      tempStock.count =
                                          _updatedStockHistory[i].count;
                                      tempSupplier.items.add(SupplierHistory(
                                          name: tempStock.name,
                                          partName: tempStock.partname,
                                          count: tempStock.count,
                                          price: tempStock.lastPrice,
                                          totalPrice: tempStock.lastPrice *
                                              tempStock.count));
                                    }

                                    /// UPDATE STOCK VALUE
                                    for (var i = 0;
                                        i < _updatedStock.length;
                                        i++) {
                                      Stock tempStock = _updatedStock[i];
                                      StockHistory history = StockHistory(
                                          supplier: _supplier,
                                          date:
                                              DateTime.now().toIso8601String(),
                                          price: tempStock.lastPrice,
                                          count: tempStock.count,
                                          totalPrice: tempStock.lastPrice *
                                              tempStock.count);

                                      tempStock.items.add(history);

                                      tempStock.totalPrice =
                                          tempStock.totalPrice +
                                              (tempStock.lastPrice *
                                                  tempStock.count);

                                      ///ADD SUPPLIER
                                      tempSupplier.count = tempSupplier.count +
                                          _updatedStockHistory[i].count;

                                      tempSupplier.totalPrice =
                                          tempSupplier.totalPrice +
                                              tempStock.lastPrice *
                                                  _updatedStockHistory[i].count;

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
                    _desc = '';
                    jumlahOpsi = 1;
                    _updatedStock = [];
                    _supplier = '';
                    _updatedStockHistory = [
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
