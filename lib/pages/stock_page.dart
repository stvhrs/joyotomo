import 'dart:convert';
import 'dart:developer';
import 'dart:math';

import 'package:data_table_2/paginated_data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../main.dart';

import '../models/stock.dart';

class StockPage extends StatefulWidget {
  const StockPage({Key? key}) : super(key: key);

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  late Stream<List<Stock>> _streamstocks;
  int _currentIndex = 0;
  late Stock _selectedStock;
  String _search = '';
  final formatCurrency = NumberFormat.simpleCurrency(locale: "id_ID");

  @override
  void initState() {
    super.initState();
    _streamstocks = objectBox.getStocks();
  }

  @override
  Widget build(BuildContext context2) {
    return Scaffold(
      body: StreamBuilder<List<Stock>>(
          stream: _streamstocks,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: Text('Please Supplay Stock'),
              );
            }
            if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text('Please Supplay Stock'),
              );
            } else {
              List<Stock> stocks = [];
              if (_search != '') {
                for (Stock element in snapshot.data!) {
                  if (element.partname.toLowerCase().startsWith(_search) ||
                      element.name.toLowerCase().startsWith(_search)) {
                    stocks.add(element);
                  }
                }
              } else {
                stocks = snapshot.data!.reversed.toList();
                _selectedStock = stocks[_currentIndex];
              }

              return Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 16),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 700,
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 300,
                                  padding: EdgeInsets.only(
                                      top: 10, right: 10, bottom: 10),
                                  height: 50,
                                  child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius:
                                            new BorderRadius.circular(4.0),
                                      ),
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 15, right: 15, bottom: 3),
                                          child: TextFormField(
                                              onChanged: (val) {
                                                setState(() {
                                                  _selectedStock = stocks[0];
                                                  _search = val.toString();
                                                });
                                              },
                                              decoration: InputDecoration(
                                                hintText:
                                                    'Search Part Name/Name',
                                                border: InputBorder.none,
                                              )))),
                                ),
                                ElevatedButton.icon(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Color.fromARGB(
                                                    255, 79, 117, 134))),
                                    onPressed: () {
                                      showDialog(
                                          context: context2,
                                          builder: (context) {
                                            String p = '';
                                            String n = '';
                                            String d = '';
                                            return AlertDialog(
                                              actionsPadding: EdgeInsets.only(
                                                  right: 15, bottom: 15),
                                              title: Text("Insert Sperpate"),
                                              content: IntrinsicHeight(
                                                child: SizedBox(
                                                  width: 500,
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .only(bottom: 20),
                                                        child: TextFormField(
                                                            onChanged: (val) {
                                                              p = val
                                                                  .toString();
                                                            },
                                                            maxLines: 1,
                                                            decoration:
                                                                InputDecoration(
                                                              hintText:
                                                                  'Part Name',
                                                              contentPadding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 10,
                                                                      top: 10,
                                                                      bottom:
                                                                          10),
                                                              fillColor:
                                                                  Colors.white,
                                                              hintStyle: TextStyle(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade600,
                                                                  fontSize: 15,
                                                                  height: 2),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            7),
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade300),
                                                              ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            7),
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade300),
                                                              ),
                                                            )),
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .only(bottom: 20),
                                                        child: TextFormField(
                                                            onChanged: (val) {
                                                              n = val
                                                                  .toString();
                                                            },
                                                            maxLines: 1,
                                                            decoration:
                                                                InputDecoration(
                                                              hintText: 'Name',
                                                              contentPadding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 10,
                                                                      top: 10,
                                                                      bottom:
                                                                          10),
                                                              fillColor:
                                                                  Colors.white,
                                                              hintStyle: TextStyle(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade600,
                                                                  fontSize: 15,
                                                                  height: 2),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            7),
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade300),
                                                              ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            7),
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade300),
                                                              ),
                                                            )),
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .only(bottom: 20),
                                                        child: TextFormField(
                                                            onChanged: (val) {
                                                              d = val
                                                                  .toString();
                                                            },
                                                            maxLines: 3,
                                                            decoration:
                                                                InputDecoration(
                                                              hintText:
                                                                  'Description',
                                                              contentPadding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 10,
                                                                      top: 10,
                                                                      bottom:
                                                                          10),
                                                              fillColor:
                                                                  Colors.white,
                                                              hintStyle: TextStyle(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade600,
                                                                  fontSize: 15,
                                                                  height: 2),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            7),
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade300),
                                                              ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            7),
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade300),
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
                                                    Stock stock = Stock(
                                                        stockHistory: json.encode([
                {
                 
                },
          
              ]),
                                                        partname: p,
                                                        name: n,
                                                        desc: d,
                                                        count: 0,
                                                        totalPrice: 0);
                                                    objectBox
                                                        .insertStock(stock);
                                                  },
                                                  child: Text("Insert"),
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                    icon: Icon(Icons.add),
                                    label: Text('Add Part Name')),
                              ],
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                                width: 700,
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, left: 16, right: 16),
                                    child: DataTable2(
                                        border: TableBorder.all(
                                            width: 2,
                                            color: Colors.black,
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft: Radius.circular(5),
                                                    topRight:
                                                        Radius.circular(5))),
                                        sortArrowIcon: Icons.arrow_upward,
                                        columnSpacing: 12,
                                        dividerThickness: 2,
                                        horizontalMargin: 12,
                                        columns: const [
                                          DataColumn(
                                            label: Center(
                                                child: Text('Part Name')),
                                          ),
                                          DataColumn(
                                            label: Center(child: Text('Name')),
                                          ),
                                          DataColumn(
                                            label: Center(
                                                child: Text('Last Price')),
                                          ),
                                          DataColumn(
                                            label: Center(
                                                child: Text('Total Price')),
                                          ),
                                          DataColumn2(
                                              label: Center(
                                                  child: Text(
                                                'Stock',
                                              )),
                                              size: ColumnSize.S),
                                        ],
                                        rows: stocks.map((e) {
                                          return DataRow2(
                                              onTap: () {
                                                setState(() {
                                                  _currentIndex =
                                                      stocks.indexOf(e);
                                                  _selectedStock = e;
                                                });
                                              },
                                              color: e == _selectedStock
                                                  ? MaterialStateProperty.all(
                                                      Colors.amber.shade200)
                                                  : MaterialStateProperty.all(
                                                      (stocks.indexOf(e)).isOdd
                                                          ? const Color
                                                                  .fromARGB(255,
                                                              193, 216, 226)
                                                          : Colors.white),
                                              cells: [
                                                DataCell(Text(e.partname)),
                                                DataCell(Text(e.name)),
                                                DataCell(Center(
                                                    child: Text(formatCurrency
                                                        .format(json.decode(
                                                                e.stockHistory)[
                                                            0]['price'])??''))),
                                                DataCell(Center(
                                                    child: Text(
                                                        formatCurrency.format(
                                                            e.totalPrice)))),
                                                DataCell(Center(
                                                    child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 10,
                                                                right: 10,
                                                                top: 2,
                                                                bottom: 2),
                                                        decoration: BoxDecoration(
                                                            color: e.count <= 10
                                                                ? Colors.red
                                                                    .shade400
                                                                : Colors.green
                                                                    .shade400,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Text(
                                                          (e.count.toString()),
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ))))
                                              ]);
                                        }).toList()))),
                          ),
                        ],
                      ),
                      _divier_,
                      Column(children: [
                        IconButton(
                            onPressed: () {
                            
                              objectBox.deleteStock(stocks[_currentIndex].id);
                              _currentIndex = 0;
                              _selectedStock = stocks[0];
                              setState(() {});
                            },
                            icon: Icon(Icons.delete)),
                        Text(
                          _selectedStock.partname,
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        Text('Description'),
                        Text(_selectedStock.desc),
                        
                    ...  (json.decode(_selectedStock.stockHistory)
                                as List<dynamic>)
                            .map((e) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(e['count'].toString()??''),
                              Text(DateFormat.yMMMMEEEEd("id_ID"??"")
                                  .format(DateTime.parse(e['date']).toLocal())??""),
                              Text(e['price'].toString()??""),
                              Text(e['supplier'].toString()??""),
                            ],
                          );
                        }).toList()
                      ])
                    ]),
              );
            }
          }),
    );
  }
}

Widget get _divier_ => Row(
      children: const [
        VerticalDivider(
          color: Color.fromARGB(255, 79, 117, 134),
          thickness: 2.5,
          width: 4,
        ),
        VerticalDivider(
          color: Color.fromARGB(255, 79, 117, 134),
          thickness: 2.5,
          width: 4,
        ),
      ],
    );
