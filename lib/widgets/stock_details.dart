import 'dart:convert';

import 'package:data_table_2/paginated_data_table_2.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/stock.dart';

class StockDetails extends StatefulWidget {
  final List<dynamic> stocksHistory;
  final bool empty;
  const StockDetails({required this.stocksHistory,required this.empty, Key? key}) : super(key: key);

  @override
  State<StockDetails> createState() => _StockDetailsState();
}

class _StockDetailsState extends State<StockDetails> {
  final formatCurrency = NumberFormat.simpleCurrency(locale: "id_ID");
  @override
  Widget build(BuildContext context) {
    print('detail');
    return SizedBox(
      height: 700,
      width: 500,
      child: DataTable2(headingRowHeight: 30,
          border: TableBorder.all(
              width: 2,
              color: Colors.black,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5), topRight: Radius.circular(5))),
          sortArrowIcon: Icons.arrow_upward,
          columnSpacing: 12,
          dividerThickness: 2,
          horizontalMargin: 12,
          columns: const [
            DataColumn(
              label: Center(child: Text('Date')),
            ),
            DataColumn(
              label: Center(child: Text('Supplier')),
            ),
            DataColumn(
              label: Center(child: Text('Price item')),
            ),
            DataColumn2(
                label: Center(
                    child: Text(
                  'Count',
                )),
                size: ColumnSize.S),
          ],
          rows:widget.empty?[]: widget.stocksHistory.map((e) {
            return DataRow2(
                color: MaterialStateProperty.all(
                    widget.stocksHistory.indexOf(e).isEven
                        ? Colors.amber.shade200
                        : Colors.white),
                cells: [
                  DataCell(
                    Text(DateFormat.yMMMMEEEEd("id_ID")
                        .format(DateTime.parse(e['date']).toLocal())),
                  ),
                  DataCell(Text(e['supplier'])),
                  DataCell(
                      Center(child: Text(formatCurrency.format(e['price'])))),
                  DataCell(Center(
                      child: Container(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 2, bottom: 2),
                          decoration: BoxDecoration(
                              color: e['count'] < 0
                                  ? Colors.red.shade400
                                  : Colors.green.shade400,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            (e['count'].toString()),
                            style: const TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ))))
                ]);
          }).toList()),
    );
  }
}
