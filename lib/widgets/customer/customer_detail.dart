
import 'package:bitsdojo_window_example/main.dart';

import 'package:bitsdojo_window_example/models/customer.dart';
import 'package:bitsdojo_window_example/provider/trigger.dart';
import 'package:bitsdojo_window_example/widgets/customer/invoice/invoice_doc.dart';
import 'package:bitsdojo_window_example/widgets/customer/realization/realization_doc.dart';
import 'package:bitsdojo_window_example/widgets/customer/spk/spk_doc.dart';
// ignore: deprecated_member_use

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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _trans.addListener(() {});
  }

  final TransformationController _trans = TransformationController();
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
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: value.selectedCustomer.namaKendaraan),
                  ],
                ),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [   InteractiveViewer(
                boundaryMargin: const EdgeInsets.all(double.infinity),
                clipBehavior: Clip.none,
                transformationController: _trans,
                child: Container(
                    margin: const EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8)),
                    height: 297,
                    width: 210,
                    child: MouseRegion(
                        cursor: SystemMouseCursors.zoomIn,
                        onExit: (event) {
                          _trans.value = Matrix4.identity();
                        },
                        onEnter: (value) {
                          _trans.value = Matrix4(
                            2.2,
                            0,
                            0,
                            0,
                            0,
                            2.2,
                            0,
                            0,
                            0,
                            0,
                            2.2,
                            0,
                            -100,
                            -150,
                            0,
                            1,
                          );
                        },
                        // onTap: () {
                        //
                        // },
                        child:  Center(child: InkWell(onTap: () {
                         Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SpkDoc(
                                  customer: value.selectedCustomer),
                            ));
                        },child: Text('g'))))),
              ),
     
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
