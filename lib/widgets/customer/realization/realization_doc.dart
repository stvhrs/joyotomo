import 'package:bitsdojo_window_example/widgets/kop.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../../helper/currency.dart';
import '../../../models/customer.dart';

class RealizationDoc extends StatefulWidget {
  final Customer customer;
  const RealizationDoc({super.key, required this.customer});

  @override
  State<RealizationDoc> createState() => _RealizationDocState();
}

class _RealizationDocState extends State<RealizationDoc> {
  final formatCurrency = NumberFormat.currency(
    locale: "id_ID",decimalDigits: 0,symbol: 'Rp '
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LayoutBuilder(builder: (context, BoxConstraints constraints) {
      return Center(
        child: Container(
          decoration: BoxDecoration(border: Border.all()),
          width: constraints.maxHeight / 1.4,
          height: constraints.maxHeight,
          child: Column(
            children: [
              const Divider(
                height: 0,
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "REALISASI",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                ),
              ),
              const Divider(
                height: 0,
                color: Colors.black,
              ),
              ...widget.customer.mpi.target!.items
                  .map((element) => element.attention == 0
                      ? const SizedBox()
                      : Container(
                          width: constraints.maxHeight / 1.4,
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                          ),
                          child: IntrinsicHeight(
                            child: Row(
                              children: [
                                Container(
                                  width: constraints.maxHeight / 1.4 / 2.8,
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          width: 1,
                                          color: Color.fromARGB(255, 0, 0, 0)),
                                    ),
                                  ),
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Transform.scale(
                                          alignment: Alignment.centerLeft,
                                          scale: 0.6,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 30,
                                                height: 16,
                                                child: Checkbox(
                                                    activeColor: Colors.green,
                                                    materialTapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    value:
                                                        element.attention == 1,
                                                    onChanged: (sd) {}),
                                              ),
                                              SizedBox(
                                                width: 30,
                                                height: 16,
                                                child: Checkbox(
                                                    activeColor: Colors.yellow,
                                                    materialTapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    value:
                                                        element.attention == 2,
                                                    onChanged: (sd) {}),
                                              ),
                                              SizedBox(
                                                width: 30,
                                                height: 16,
                                                child: Checkbox(
                                                    activeColor: Colors.red,
                                                    materialTapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    value:
                                                        element.attention == 3,
                                                    onChanged: (sd) {}),
                                              )
                                            ],
                                          )),
                                      Positioned(
                                        left: 55,
                                        top: 1,
                                        child: Text(
                                          element.name,
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                    width: 100,
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                        formatCurrency.format(element.price),
                                        style: const TextStyle(
                                          fontSize: 12,
                                        ))),
                                const VerticalDivider(
                                  color: Colors.black,
                                ),
                                Container(
                                  width: 200,
                                  // margin: EdgeInsets.only(left: 10),
                                  child: Text(element.remark,
                                      style: const TextStyle(
                                        fontSize: 12,
                                      )),
                                ),
                              ],
                            ),
                          )))
                  .toList()
            ],
          ),
        ),
      );
    }));
  }
}
