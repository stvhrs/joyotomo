import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:bitsdojo_window_example/main.dart';
import 'package:bitsdojo_window_example/models/supplier.dart';
import 'package:bitsdojo_window_example/widgets/stock/supplier/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../models/stock.dart';
import '../../../provider/triger.dart';

class SupplierAdd extends StatefulWidget {
  @override
  State<SupplierAdd> createState() => _SupplierAddState();
}

class _SupplierAddState extends State<SupplierAdd> {
  String d = '';
  TextEditingController _controller = TextEditingController();
  int jumlahOpsi = 1;

  List<Stock> _updatedStock = [];

  String _supplier = '';

  List<Map<String, dynamic>> data = [
    {
      'date': DateTime.now().toIso8601String(),
      'supplier': '',
      'count': 1,
      'totalPrice': 0,
      'price': 0,
    }
  ];
  // @override
  // void initState() {
  //   objectBox.insertSupplier(Supplier(
  //       date: DateTime.now().toIso8601String(),
  //       supplierHistory: '[]',
  //       supplier: 'Mandiri',
  //       desc: 'dad',
  //       count: 1,
  //       totalPrice: 1000));
  //   super.initState();
  // }

  Widget _buildPartName(int i, BuildContext context) {
    List<Stock> stocks =
        Provider.of<Trigger>(context, listen: false).listSelectedStock;
    log(data.toString());
    for (var element in _updatedStock) {
      log(element.partname);
    }
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 300,
                  child: DropDownField(
                    required: true,
                    onValueChanged: (val) {
                      if (stocks
                          .map((e) => e.partname)
                          .toList()
                          .contains(val)) {
                        if (_updatedStock.length < i + 1) {
                          _updatedStock.insert(
                              i,
                              stocks.firstWhere(
                                  (element) => element.partname == val)!);
                          log(_updatedStock.length.toString());
                        }

                        setState(() {});
                      } else {
                        // stock = null;
                        //  setState(() {});
                      }
                    },
                    strict: true,
                    labelText: 'PartName',
                    items: stocks.map((e) => e.partname).toList(),
                  ),
                ),
                Spacer(),
                IconButton(
                    onPressed: () {
                      setState(() {});
                      if (data[i]['count'] > 1) {
                        setState(() {
                          data[i]['count']--;
                        });
                      }
                    },
                    icon: Icon(Icons.remove_circle)),
                Text(data[i]['count'].toString()),
                IconButton(
                    onPressed: () {
                      setState(() {
                        data[i]['count']++;
                      });
                    },
                    icon: Icon(Icons.add_circle)),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    List<Supplier> suppliers =
        Provider.of<Trigger>(context, listen: false).listSelectedSupplier;
    List<Stock> stocks =
        Provider.of<Trigger>(context, listen: false).listSelectedStock;
    List<String> itemsSupplier = [];
    if (suppliers.isNotEmpty) {
      for (Supplier e in suppliers) {
        if (!itemsSupplier.contains(e.supplier)) {
          itemsSupplier.add(e.supplier);
        }
      }
    } else {
      itemsSupplier.add(_supplier);
    }

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: ElevatedButton.icon(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 79, 117, 134))),
          onPressed: stocks.isEmpty
              ? () {}
              : () {
                  if (suppliers.isEmpty) {}
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                            actionsPadding:
                                const EdgeInsets.only(right: 15, bottom: 15),
                            title: const Text("Kulakan"),
                            content: StatefulBuilder(
                              builder: (BuildContext context,
                                      StateSetter setState) =>
                                  IntrinsicHeight(
                                child: SizedBox(
                                  width: 500,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      DropDownField(
                                        required: true,
                                        strict: true,
                                        controller: _controller,
                                        labelText: 'Supplier',
                                        onValueChanged: (v) {
                                          _supplier = v;
                                        },
                                        items: itemsSupplier,
                                      ),
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 20),
                                        child: TextFormField(
                                            onChanged: (val) {},
                                            maxLines: 3,
                                            decoration: InputDecoration(
                                              hintText: 'Description',
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 10,
                                                      top: 10,
                                                      bottom: 10),
                                              fillColor: Colors.white,
                                              hintStyle: TextStyle(
                                                  color: Colors.grey.shade600,
                                                  fontSize: 15,
                                                  height: 2),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                                borderSide: BorderSide(
                                                    color:
                                                        Colors.grey.shade300),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                                borderSide: BorderSide(
                                                    color:
                                                        Colors.grey.shade300),
                                              ),
                                            )),
                                      ),
                                      ...List.generate(
                                          jumlahOpsi,
                                          (index) =>
                                              _buildPartName(index, context)),
                                      Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (jumlahOpsi > 1 &&
                                                      jumlahOpsi ==
                                                          _updatedStock
                                                              .length) {
                                                    _updatedStock.removeAt(
                                                        jumlahOpsi - 1);
                                                    data.removeAt(
                                                        jumlahOpsi - 1);
                                                    jumlahOpsi = jumlahOpsi - 1;
                                                  }
                                                });
                                              },
                                              icon: Icon(Icons.remove_circle)),
                                          // Text(jumlahOpsi.toString()),
                                          IconButton(
                                              onPressed: () {
                                                if (jumlahOpsi ==
                                                    _updatedStock.length) {
                                                  setState(() {
                                                    jumlahOpsi = jumlahOpsi + 1;
                                                    data.add({
                                                      'date': DateTime.now()
                                                          .toIso8601String(),
                                                      'supplier': _supplier,
                                                      'count': 1,
                                                      'totalPrice': 0,
                                                      'price': 0,
                                                    });
                                                  });
                                                }
                                              },
                                              icon: Icon(Icons.add_circle)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                onPressed: () {
                                  log(_supplier);
                                  _supplier = _controller.text;
                                  if (_supplier != '') {
                                    log(data.toString());
                                    for (var element in _updatedStock) {
                                      log(element.partname);
                                    }
                                    for (var i = 0;
                                        i < _updatedStock.length;
                                        i++) {
                                      final supp = Supplier(
                                          date:
                                              DateTime.now().toIso8601String(),
                                          supplierHistory: json.encode([
                                            {
                                              'count': 0,
                                              'partName': 'asdsd',
                                              'price': 0,
                                              'totalPrice': 0
                                            }
                                          ]),
                                          supplier: 'test',
                                          desc: 'desc',
                                          count: 69,
                                          totalPrice: 69);
                                      Stock stock = _updatedStock[i];
                                      supp.items.add(stock);
                                       objectBox.insertSupplier(supp);
                                      List history =
                                          json.decode(stock.stockHistory);
                                      data[i]['supplier'] = _supplier;
                                      history.add(data[i]);
                                      stock.stockHistory = json.encode(history);
                                      stock.count = stock.count +
                                          (data[i]['count'] as int);
                                      stock.lastPrice = 100;
                                      log(history.toString());
                                      objectBox.insertStock(stock);
                                      // objectBox.insertSupplier(Supplier(
                                      //     date:
                                      //         DateTime.now().toIso8601String(),
                                      //     supplierHistory: json.encode([
                                      //       {
                                      //         'count': 0,
                                      //         'partName': 'asdsd',
                                      //         'price': 0,
                                      //         'totalPrice': 0
                                      //       }
                                      //     ]),
                                      //     supplier: _supplier,
                                      //     desc: d,
                                      //     count: 99,
                                      //     totalPrice: 99));
                                    
                                    }  Navigator.of(context).pop();
                                  }
                                },
                                child: const Text("Reduce"),
                              ),
                            ]);
                      }).then((value) {
                    d = '';
                    jumlahOpsi = 1;
                    _updatedStock = [];
                    _supplier = '';
                    data = [
                      {
                        'date': DateTime.now().toIso8601String(),
                        'supplier': '',
                        'count': 1,
                        'totalPrice': 0,
                        'price': 0,
                      }
                    ];
                  });
                },
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          label: const Text(
            'Add Supplier',
            style: TextStyle(color: Colors.white),
          )),
    );
  }
}

class DropDownField extends FormField<String> {
  final dynamic value;
  final Widget? icon;
  final String? hintText;
  final TextStyle hintStyle;
  final String? labelText;
  final TextStyle labelStyle;
  final TextStyle textStyle;
  final bool required;
  final bool enabled;
  final List<dynamic>? items;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldSetter<dynamic>? setter;
  final ValueChanged<dynamic>? onValueChanged;
  final bool strict;
  final int itemsVisibleInDropdown;
  TextEditingController? controller;

  DropDownField(
      {Key? key,
      this.controller,
      this.value,
      this.required: false,
      this.icon,
      this.hintText,
      this.hintStyle: const TextStyle(
          fontWeight: FontWeight.normal, color: Colors.grey, fontSize: 18.0),
      this.labelText,
      this.labelStyle: const TextStyle(
          fontWeight: FontWeight.normal, color: Colors.grey, fontSize: 18.0),
      this.inputFormatters,
      this.items,
      this.textStyle: const TextStyle(
          fontWeight: FontWeight.bold, color: Colors.black, fontSize: 14.0),
      this.setter,
      this.onValueChanged,
      this.itemsVisibleInDropdown: 3,
      this.enabled: true,
      this.strict: true})
      : super(
          key: key,
          initialValue: controller != null ? controller.text : (value ?? ''),
          onSaved: setter,
          builder: (FormFieldState<String> field) {
            final DropDownFieldState state = field as DropDownFieldState;
            final ScrollController _scrollController = ScrollController();
            final InputDecoration effectiveDecoration = InputDecoration(
                border: InputBorder.none,
                filled: true,
                icon: icon,
                suffixIcon: IconButton(
                    icon: Icon(Icons.arrow_drop_down,
                        size: 30.0, color: Colors.black),
                    onPressed: () {
                      SystemChannels.textInput.invokeMethod('TextInput.hide');
                      state.setState(() {
                        state._showdropdown = !state._showdropdown;
                      });
                    }),
                hintStyle: hintStyle,
                labelStyle: labelStyle,
                hintText: hintText,
                labelText: labelText);

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        // autovalidate: true,
                        controller: state._effectiveController,
                        decoration: effectiveDecoration.copyWith(
                            errorText: field.errorText),
                        style: textStyle,
                        textAlign: TextAlign.start,
                        autofocus: false,
                        obscureText: false,
                        //     maxLengthEnforced: true,
                        maxLines: 1,
                        validator: (String? newValue) {
                          if (required) {
                            if (newValue == null || newValue.isEmpty)
                              return 'This field cannot be empty!';
                          }

                          //Items null check added since there could be an initial brief period of time
                          //when the dropdown items will not have been loaded
                          if (items != null) {
                            if (strict &&
                                newValue!.isNotEmpty &&
                                !items.contains(newValue))
                              return 'Invalid value in this field!';
                          }

                          return null;
                        },
                        onSaved: setter,
                        enabled: enabled,
                        inputFormatters: inputFormatters,
                      ),
                    ),
                  ],
                ),
                !state._showdropdown
                    ? Container()
                    : Container(
                        alignment: Alignment.topCenter,
                        height: itemsVisibleInDropdown *
                            48.0, //limit to default 3 items in dropdownlist view and then remaining scrolls
                        width: MediaQuery.of(field.context).size.width,
                        child: ListView(
                          cacheExtent: 0.0,
                          scrollDirection: Axis.vertical,
                          controller: _scrollController,
                          padding: EdgeInsets.only(left: 40.0),
                          children: items!.isNotEmpty
                              ? ListTile.divideTiles(
                                      context: field.context,
                                      tiles: state._getChildren(state._items!))
                                  .toList()
                              : [],
                        ),
                      ),
              ],
            );
          },
        );

  @override
  DropDownFieldState createState() => DropDownFieldState();
}

class DropDownFieldState extends FormFieldState<String> {
  TextEditingController? _controller;
  bool _showdropdown = false;
  bool _isSearching = true;
  String _searchText = "";

  @override
  DropDownField get widget => super.widget as DropDownField;
  TextEditingController? get _effectiveController =>
      widget.controller ?? _controller;

  List<String>? get _items => widget.items as List<String>?;

  void toggleDropDownVisibility() {}

  void clearValue() {
    setState(() {
      _effectiveController!.text = '';
    });
  }

  @override
  void didUpdateWidget(DropDownField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null)
        _controller =
            TextEditingController.fromValue(oldWidget.controller!.value);
      if (widget.controller != null) {
        setValue(widget.controller!.text);
        if (oldWidget.controller == null) _controller = null;
      }
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _isSearching = false;
    if (widget.controller == null) {
      _controller = TextEditingController(text: widget.initialValue);
    }

    _effectiveController!.addListener(_handleControllerChanged);

    _searchText = _effectiveController!.text;
  }

  @override
  void reset() {
    super.reset();
    setState(() {
      _effectiveController!.text = widget.initialValue!;
    });
  }

  List<ListTile> _getChildren(List<String> items) {
    List<ListTile> childItems = [];
    for (var item in items) {
      if (_searchText.isNotEmpty) {
        if (item.toUpperCase().contains(_searchText.toUpperCase()))
          childItems.add(_getListTile(item));
      } else {
        childItems.add(_getListTile(item));
      }
    }
    _isSearching ? childItems : [];
    return childItems;
  }

  ListTile _getListTile(String text) {
    return ListTile(
      dense: true,
      title: Text(
        text,
      ),
      onTap: () {
        setState(() {
          _effectiveController!.text = text;
          _handleControllerChanged();
          _showdropdown = false;
          _isSearching = false;
          if (widget.onValueChanged != null) widget.onValueChanged!(text);
        });
      },
    );
  }

  void _handleControllerChanged() {
    if (_effectiveController!.text != value)
      didChange(_effectiveController!.text);

    if (_effectiveController!.text.isEmpty) {
      setState(() {
        _isSearching = false;
        _searchText = "";
      });
    } else {
      setState(() {
        _isSearching = true;
        _searchText = _effectiveController!.text;
        _showdropdown = true;
      });
    }
  }
}
