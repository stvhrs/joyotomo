import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';

import 'package:bitsdojo_window_example/main.dart';
import 'package:bitsdojo_window_example/provider/triger.dart';
import 'package:bitsdojo_window_example/widgets/stock_remove.dart';
import 'package:data_table_2/paginated_data_table_2.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/stock.dart';

class StockDetails extends StatefulWidget {
  // final List<dynamic> stocksHistory;
  // final bool empty;
  const StockDetails({Key? key}) : super(key: key);

  @override
  State<StockDetails> createState() => _StockDetailsState();
}

class _StockDetailsState extends State<StockDetails> {
 
  final formatCurrency = NumberFormat.simpleCurrency(locale: "id_ID");
  @override
  Widget build(BuildContext context) {
    print('detail');
    return Consumer<Trigger>(builder: (context, value, cshild) {
      final List<dynamic> history =
          (json.decode(value.selectedStock.stockHistory) as List<dynamic>).reversed.toList();

      log(history.toString());
      return IntrinsicWidth(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value.selectedStock.partname,
                style:
                    const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              IconButton(
                  onPressed: () {
                    Stock stock = Provider.of<Trigger>(context, listen: false)
                        .selectedStock;
                    objectBox.deleteStock(stock.id);
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red.shade900,
                  )),
            ],
          ),
          Text(
            value.selectedStock.name,
            style: TextStyle(
                color: Colors.grey.shade800,
                fontSize: 26,
                fontWeight: FontWeight.bold),
          ),
        Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(bottom: 40, top: 10),
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(5)),
              child: Text(value.selectedStock.desc)),
              
               (value.selectedStock.stockHistory != '[{}]')? StockRemove():SizedBox(),
         
          Expanded(
              child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width / 3,
            child: DataTable2(
                headingRowHeight: 30,
                border: TableBorder.all(
                    width: 2,
                    color: Colors.black,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5))),
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
                rows: value.selectedStock.stockHistory == '[{}]'
                    ? []
                    : history.map((e) {
                        return DataRow2(
                            color: MaterialStateProperty.all(
                                history.indexOf(e).isEven
                                    ? Colors.amber.shade200
                                    : Colors.white),
                            cells: [
                              DataCell(
                                Text(DateFormat.yMMMMEEEEd("id_ID").format(
                                    DateTime.parse(e['date']).toLocal())),
                              ),
                              DataCell(Text(e['supplier'])),
                              DataCell(Center(
                                  child:
                                      Text(formatCurrency.format(e['price'])))),
                              DataCell(Center(
                                  child: Container(
                                      padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 2,
                                          bottom: 2),
                                      decoration: BoxDecoration(
                                          color: e['count'] < 0
                                              ? Colors.red.shade400
                                              : Colors.green.shade400,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                        (e['count'].toString()),
                                        style: const TextStyle(
                                            color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ))))
                            ]);
                      }).toList()),
          ))
        ]),
      );
    });
  }
}
