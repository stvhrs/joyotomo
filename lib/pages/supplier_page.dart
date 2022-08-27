import 'package:bitsdojo_window_example/widgets/stock/supplier/supplier_add.dart';
import 'package:flutter/material.dart';

import 'package:bitsdojo_window_example/provider/triger.dart';

import 'package:data_table_2/paginated_data_table_2.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../main.dart';

import '../models/supplier.dart';
import '../widgets/stock/supplier/supplier_details.dart';

class SupplierPage extends StatefulWidget {
  const SupplierPage({Key? key}) : super(key: key);

  @override
  State<SupplierPage> createState() => _SupplierPageState();
}

class _SupplierPageState extends State<SupplierPage> {
  late Stream<List<Supplier>> _streamSuppliers;
  final int _currentIndex = 0;
  late Supplier _selectedSupplier;
  String _search = '';

  @override
  void initState() {
    _streamSuppliers = objectBox.getSuppliers();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print('didi');

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context2) {
    print('buil addll');
    return Scaffold(
      body: StreamBuilder<List<Supplier>>(
          stream: _streamSuppliers,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return SizedBox();
            }
            if (snapshot.data!.isEmpty) {
              return const Center(
                child: SupplierAdd(),
              );
            } else {
              List<Supplier> Suppliers = [];
              if (_search != '') {
                for (Supplier element in snapshot.data!) {
                  if (element.supplier
                      .toLowerCase()
                      .startsWith(_search.toLowerCase())) {
                    Suppliers.add(element);
                  }
                }
              } else {
                Suppliers = snapshot.data!.reversed.toList();

                _selectedSupplier = Suppliers[_currentIndex];
                Provider.of<Trigger>(context, listen: false)
                    .selectSupplier(_selectedSupplier, false);
              }

              return Consumer<Trigger>(builder: (context, val, c) {
                return Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 2,
                              padding:
                                  const EdgeInsets.only(left: 16, right: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 4,
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
                                                      if (Suppliers
                                                          .isNotEmpty) {
                                                        _selectedSupplier =
                                                            Suppliers[0];
                                                      }
                                                      // _streamSuppliers =
                                                      //     objectBox.getSuppliers(
                                                      //         val.toString());
                                                      _search = val.toString();
                                                      // }
                                                    },
                                                  );
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                  hintText: 'Search Supplier',
                                                  border: InputBorder.none,
                                                )))),
                                  ),
                                  const SupplierAdd()
                                ],
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8, left: 16, right: 16),
                                      child: PaginatedDataTable2(
                                        wrapInCard: false,
                                        rowsPerPage: 20,
                                        source: UserDataTableSource(
                                            userData: Suppliers,
                                            context: context),
                                        headingRowHeight: 40,
                                        minWidth: 300,
                                        border: TableBorder.all(
                                            width: 2,
                                            color: Colors.black,
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft: Radius.circular(5),
                                                    topRight:
                                                        Radius.circular(5))),
                                        sortArrowIcon: Icons.arrow_upward,
                                        columnSpacing: 0,
                                        horizontalMargin: 0,
                                        columns: const [
                                          DataColumn(
                                            label: Center(child: Text('Date')),
                                          ),
                                          DataColumn(
                                            label:
                                                Center(child: Text('Supplier')),
                                          ),
                                          DataColumn(
                                            label: Center(
                                                child: Text('Total Harga')),
                                          ),
                                          DataColumn2(
                                            size: ColumnSize.S,
                                            label: Center(
                                                child: Text(
                                              'Count',
                                            )),
                                          ),
                                        ],
                                      ))),
                            ),
                          ],
                        ),
                        _divier_,
                        SupplierDetails(),
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

class UserDataTableSource extends DataTableSource {
  UserDataTableSource({required List<Supplier> userData, required this.context})
      : _userData = userData;
  final BuildContext context;
  final List<Supplier> _userData;
  final formatCurrency = NumberFormat.simpleCurrency(locale: "id_ID");
  @override
  DataRow getRow(int index) {
    assert(index >= 0);

    if (index >= _userData.length) {
      return const DataRow(cells: []);
    }
    final _user = _userData[index];
    Supplier _selectedSupplier =
        Provider.of<Trigger>(context, listen: true).selectedSupplier;

    return DataRow2.byIndex(
        color: MaterialStateProperty.all(index.isEven
            ? const Color.fromARGB(255, 193, 216, 226)
            : Colors.transparent),
        onTap: () {
          Provider.of<Trigger>(context, listen: false)
              .selectSupplier(_user, true);
        },
        index: index,
        cells: [
          DataCell(Container(
              width: double.infinity,
              height: double.infinity,
              color: _selectedSupplier == _user
                  ? Colors.amber.shade200
                  : Colors.transparent,
              child: Center(
                child: Text(DateFormat.yMMMMEEEEd("id_ID")
                    .format(DateTime.parse(_user.date).toLocal())),
              ))),
          DataCell(Container(
              width: double.infinity,
              height: double.infinity,
              color: _selectedSupplier == _user
                  ? Colors.amber.shade200
                  : Colors.transparent,
              child: Center(
                child: Text(_user.totalPrice.toString()),
              ))),
          DataCell(Container(
              width: double.infinity,
              height: double.infinity,
              color: _selectedSupplier == _user
                  ? Colors.amber.shade200
                  : Colors.transparent,
              child: Center(
                child: Text(formatCurrency.format(_user.totalPrice)),
              ))),
          DataCell(Center(
              child: Container(
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, left: 35, right: 35),
            width: double.infinity,
            height: double.infinity,
            color: _selectedSupplier == _user
                ? Colors.amber.shade200
                : Colors.transparent,
            child: Container(
                alignment: Alignment.center,
                // margin: const EdgeInsets.only(
                //     left: 30, right: 30, top: 10, bottom: 10),
                decoration: BoxDecoration(
                    color: _user.count < 11
                        ? Colors.red.shade400
                        : Colors.green.shade400,
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  (_user.count.toString()),
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                )),
          )))
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _userData.length;

  @override
  int get selectedRowCount => 0;

  void sort<T>(Comparable<T> Function(Supplier d) getField, bool ascending) {
    _userData.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    notifyListeners();
  }
}
