import 'dart:developer';

import 'package:bitsdojo_window_example/main.dart';

import 'package:bitsdojo_window_example/models/customer.dart';
import 'package:bitsdojo_window_example/provider/trigger.dart';
import 'package:bitsdojo_window_example/widgets/customer/invoice/invoice_doc.dart';
import 'package:bitsdojo_window_example/widgets/customer/realization/realization_doc.dart';
import 'package:bitsdojo_window_example/widgets/customer/mpi/mpi_doc.dart';
import 'package:bitsdojo_window_example/widgets/customer/spk/spk_doc.dart';
import 'package:bitsdojo_window_example/widgets/kop.dart';
import 'dart:math' as math;
// ignore: deprecated_member_use
import 'package:data_table_2/paginated_data_table_2.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CustomerDetails extends StatefulWidget {
  // final List<dynamic> CustomersHistory;
  // final bool empty;
  const CustomerDetails({Key? key}) : super(key: key);

  @override
  State<CustomerDetails> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
  final formatCurrency = NumberFormat.simpleCurrency(locale: "id_ID");
  @override
  Widget build(BuildContext context) {
    return Consumer<Trigger>(builder: (context, value, cshild) {
      return IntrinsicWidth(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value.selectedCustomer.namaKendaraan,
                style:
                    const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              IconButton(
                  onPressed: () {
                    Customer customer =
                        Provider.of<Trigger>(context, listen: false)
                            .selectedCustomer;
                    objectBox.deleteCustomer(customer.id);
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red.shade900,
                  )),
            ],
          ),
          Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(bottom: 40, top: 10),
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(5)),
              child: RichText(
                overflow: TextOverflow.clip,
                text: TextSpan(
                  text: 'Alamat : ',
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                        text: value.selectedCustomer.alamat + '\n',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: value.selectedCustomer.namaKendaraan),
                  ],
                ),
              )),
          Row(
            children: [
              Transform(
                transform: scaleXYZTransform(scaleX: 0.5, scaleY: 0.5),
                child: Transform.rotate(
                  angle: -math.pi / 2.0,
                  child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              SpkDoc(customer: value.selectedCustomer),
                        ));
                      },
                      child: Container(
                          color: Colors.green,
                          height: 300,
                          width: 440,
                          child: Kop())),
                ),
              ),
              // Transform(
              //     transform: scaleXYZTransform(scaleX: .8, scaleY: .8),
              //     child: Transform.rotate(
              //         angle: -math.pi / 2.0,
              //         child: SizedBox(
              //   height: 200,
              //   width: 300,
              //   child: InkWell(
              //             onTap: () {
              //               Navigator.of(context).push(MaterialPageRoute(
              //                 builder: (context) =>
              //                     SpkDoc(customer: value.selectedCustomer),
              //               ));
              //             },
              //             child: SpkDoc(customer: value.selectedCustomer))),
              //   ),
              // ),
              // Transform.scale(
              //     scale: 0.1,
              //     child: SizedBox(
              //       height: 300,
              //       width: 400,
              //       child: InkWell(
              //           onTap: () {
              //             Navigator.of(context).push(MaterialPageRoute(
              //               builder: (context) =>
              //                   SpkDoc(customer: value.selectedCustomer),
              //             ));
              //           },
              //           child: Transform.rotate(
              //               angle: -math.pi / 2.0,
              //               child: SpkDoc(customer: value.selectedCustomer))),
              //     )), Transform.scale(
              //     scale: 0.1,
              //     child: SizedBox(
              //       height: 300,
              //       width: 400,
              //       child: InkWell(
              //           onTap: () {
              //             Navigator.of(context).push(MaterialPageRoute(
              //               builder: (context) =>
              //                   SpkDoc(customer: value.selectedCustomer),
              //             ));
              //           },
              //           child: Transform.rotate(
              //               angle: -math.pi / 2.0,
              //               child: SpkDoc(customer: value.selectedCustomer))),
              //     )), Transform.scale(
              //     scale: 0.1,
              //     child: SizedBox(
              //       height: 300,
              //       width: 400,
              //       child: InkWell(
              //           onTap: () {
              //             Navigator.of(context).push(MaterialPageRoute(
              //               builder: (context) =>
              //                   SpkDoc(customer: value.selectedCustomer),
              //             ));
              //           },
              //           child: Transform.rotate(
              //               angle: -math.pi / 2.0,
              //               child: SpkDoc(customer: value.selectedCustomer))),
              //     )),

              ///
              // InkWell(
              //     onTap: () {
              //       Navigator.of(context).push(MaterialPageRoute(
              //         builder: (context) =>
              //             RealizationDoc(customer: value.selectedCustomer),
              //       ));
              //     },
              //     child: Transform.scale(
              //         scale: 1,
              //         child: MpiDoc(customer: value.selectedCustomer))),
              ///
              // InkWell(
              //     onTap: () {
              //       Navigator.of(context).push(MaterialPageRoute(
              //         builder: (context) =>
              //             MpiDoc(customer: value.selectedCustomer),
              //       ));
              //     },
              //     child: Transform.scale(
              //         scale: 1,
              //         child: RealizationDoc(customer: value.selectedCustomer))),
              // InkWell(
              //     onTap: () {
              //       Navigator.of(context).push(MaterialPageRoute(
              //         builder: (context) =>
              //             InvoiceDoc(customer: value.selectedCustomer),
              //       ));
              //     },
              //     child: Transform.scale(
              //         scale: 1,
              //         child: InvoiceDoc(customer: value.selectedCustomer))),
            ],
          )
        ]),
      );
    });
  }

  Matrix4 scaleXYZTransform({
    double scaleX = 1.00,
    double scaleY = 1.00,
    double scaleZ = 1.00,
  }) {
    return Matrix4.diagonal3Values(scaleX, scaleY, scaleZ);
  }
}
