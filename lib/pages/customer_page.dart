// ignore_for_file: deprecated_member_use

import 'package:bitsdojo_window_example/models/customer.dart';
import 'package:bitsdojo_window_example/provider/trigger.dart';
import 'package:bitsdojo_window_example/widgets/customer/customer_add.dart';
import 'package:bitsdojo_window_example/widgets/customer/customer_detail.dart';

import 'package:data_table_2/paginated_data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../main.dart';

import '../models/stock.dart';
import '../widgets/stock/stock_add.dart';
import '../widgets/stock/stock_details.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({Key? key}) : super(key: key);

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  late Stream<List<Customer>> _streamcustomers;
  final int _currentIndex = 0;
  late Customer _selectedCustomers;
  String _search = '';

  @override
  void initState() {
    _streamcustomers = objectBox.getCustomers();
    super.initState();
  }

  @override
  Widget build(BuildContext context2) {
    return Scaffold(
      body: StreamBuilder<List<Customer>>(
          stream: _streamcustomers,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            }
            if (snapshot.data!.isEmpty) {
              return const Center(
                  child: CustomerAdd(
                csId: 'CS/1',
              ));
            } else {
              List<Customer> customers = [];
              if (_search != '') {
                for (Customer element in snapshot.data!) {
                  if (element.customerName
                          .toLowerCase()
                          .startsWith(_search.toLowerCase()) ||
                      element.namaKendaraan
                          .toLowerCase()
                          .startsWith(_search.toLowerCase())) {
                    customers.add(element);
                  }
                }
              } else {
                customers = snapshot.data!.reversed.toList();
                _selectedCustomers = customers[_currentIndex];
                Provider.of<Trigger>(context, listen: false)
                    .selectCustomer(_selectedCustomers, false);
                Provider.of<Trigger>(context, listen: false)
                    .selectListCustomer(customers, false);
              }

              return Consumer<Trigger>(builder: (context, val, c) {
                return Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(children: [
                          Container(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [  CustomerAdd(csId: 'CS/'+customers.length.toString()),
                                Container(
                                  width: MediaQuery.of(context).size.width / 6,
                                  padding: const EdgeInsets.only(
                                      top: 10, right: 10, bottom: 10),
                                  height: 50,
                                  child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15, right: 15, bottom: 3),
                                          child: TextFormField(
                                              onChanged: (val) {
                                                setState(
                                                  () {
                                                    if (customers.isNotEmpty) {
                                                      _selectedCustomers =
                                                          customers[0];
                                                    }
                                                    // _streamcustomers =
                                                    //     objectBox.getcustomers(
                                                    //         val.toString());
                                                    _search = val.toString();
                                                    // }
                                                  },
                                                );
                                              },
                                              decoration: const InputDecoration(
                                                hintText:
                                                    'Search Part Name/Name',
                                                border: InputBorder.none,
                                              )))),
                                ),
                               
                              ],
                            ),
                          ),
                          Expanded(
                              child: SizedBox(
                                  width: MediaQuery.of(context).size.width / 6,
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8, left: 16, right: 16),
                                      child: ListView(
                                        children: customers
                                            .map((e) => InkWell(
                                                onTap: () {
                                                  Provider.of<Trigger>(context,
                                                          listen: false)
                                                      .selectCustomer(e, true);
                                                },
                                                child: Text(e.customerName)))
                                            .toList(),
                                      ))))
                        ]),
                        _divier_,
                        const CustomerDetails(),
                      ]),
                );
              });
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
