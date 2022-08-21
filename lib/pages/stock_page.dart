import 'package:data_table_2/paginated_data_table_2.dart';
import 'package:flutter/material.dart';

import '../main.dart';

import '../models/stock.dart';
import '../models/obejct.dart';

class StockPage extends StatefulWidget {
  const StockPage({Key? key}) : super(key: key);

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  // List<Stock> asu2 = [
  //   Stock(
  //       name: 'name test',
  //       desc: 'test dest',
  //       stock: 3,
  //       price: 100,
  //       totalPrice: 300,
  //       stockHistory: [
  //         StockHistory(
  //           suppiler: 'suplier',
  //           date: DateTime.now().toIso8601String(),
  //           price: 100,
  //           totalPrice: 100,
  //           count: 1,
  //         )
  //       ]),
  // ];
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  late Stream<List<Stock>> streamstocks;

  @override
  void initState() {
    super.initState();

    streamstocks = objectBox.getStocks();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Stock>>(
        stream: streamstocks,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final stocks = snapshot.data!;
            // List<User> realstocks = [];
            // for (var element in stocks) {
            //   if (element.runtimeType == User) {
            //     realstocks.add(element);
            //   }
            // }
            return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: 800,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: DataTable2(
                            border: TableBorder.all(
                                width: 2,
                                borderRadius:
                                    BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))),
                            sortArrowIcon: Icons.arrow_upward,
                            columnSpacing: 12,
                            dividerThickness: 2,
                            horizontalMargin: 12,
                            minWidth: 600,
                            columns: [
                              DataColumn(
                                label: Center(child: Text('Part Name')),
                              ),
                              DataColumn(
                                label: Center(child: Text('Name')),
                              ),
                              DataColumn(
                                label: Center(child: Text('Total Price')),
                              ),
                              DataColumn2(
                                label: Center(child: Text('Stock')),size: ColumnSize.S
                              ),
                              DataColumn(
                                label: Text('Column NUMBERS'),
                                numeric: true,
                              ),
                            ],
                            rows: List<DataRow>.generate(
                                100,
                                (index) => DataRow2(
                                        onTap: () {
                                          print('asd');
                                        },
                                        color: MaterialStateProperty.all(index
                                                .isEven
                                            ? Color.fromARGB(255, 79, 117, 134)
                                            : Colors.white),
                                        cells: [
                                          DataCell(InkWell(
                                              hoverColor: Colors.blue,
                                              child: Text('ABCDEFGH'))),
                                          DataCell(Text(
                                              'B' * (10 - (index + 5) % 10))),
                                          DataCell(Text(
                                              'C' * (15 - (index + 5) % 10))),
                                          DataCell(Text(
                                              'D' * (15 - (index + 10) % 10))),
                                          DataCell(Text(((index + 0.1) * 25.4)
                                              .toString()))
                                        ]))),
                      ))
                ]);
          }
        });
  }
}
