// import 'dart:developer';

// import 'package:bitsdojo_window_example/widgets/stock/supplier/supplier_add.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../../models/stock.dart';
// import '../../../provider/triger.dart';

// class Option extends StatefulWidget {
//   final int count;
//   const Option(this.count, {Key? key}) : super(key: key);

//   @override
//   State<Option> createState() => _OptionState();
// }

// class _OptionState extends State<Option> {
//   final List<Stock> _updatedStock = [];
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         itemCount: widget.count,
//         itemBuilder: (context, i) {
//           List<Stock> stocks =
//               Provider.of<Trigger>(context, listen: false).listSelectedStock;
//           Stock? stock;
//           int angka = 1;
//           if (_updatedStock.length == i + 1) {
//             log('sama');
//             log(_updatedStock.length.toString());
//             stock = _updatedStock[i];
//           }
//           return StatefulBuilder(
//               builder: (BuildContext context, StateSetter setState) => Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         width: 300,
//                         child: DropDownField(
//                           required: true,
//                           onValueChanged: (val) {
//                             if (stocks
//                                 .map((e) => e.name)
//                                 .toList()
//                                 .contains(val)) {
//                               stock = stocks.firstWhere(
//                                   (element) => element.partname == val);
//                               print(i + 1);
//                               if (_updatedStock.length < i + 1) {
//                                 _updatedStock.insert(i, stock!);
//                                 log(_updatedStock.length.toString());
//                               }

//                               setState(() {});
//                             } else {
//                               // stock = null;
//                               //  setState(() {});
//                             }
//                           },
//                           strict: true,
//                           labelText: 'PartName',
//                           items: stocks.map((e) => e.partname).toList(),
//                         ),
//                       ),
//                       Spacer(),
//                       stock == null
//                           ? SizedBox()
//                           : IconButton(
//                               onPressed: () {
//                                 if (angka > 1) {
//                                   setState(() {
//                                     angka--;
//                                   });
//                                 }
//                               },
//                               icon: Icon(Icons.remove_circle)),
//                       stock == null ? SizedBox() : Text(angka.toString()),
//                       stock == null
//                           ? SizedBox()
//                           : IconButton(
//                               onPressed: () {
//                                 setState(() {
//                                   angka++;
//                                 });
//                               },
//                               icon: Icon(Icons.add_circle)),
//                     ],
//                   ));
//         });
//   }
// }
