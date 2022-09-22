import 'package:flutter/material.dart';

import '../../../models/customer.dart';


class RealizationDoc extends StatelessWidget {
  final Customer customer;
  const RealizationDoc({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return Hero(tag: customer, child: Container(
          child: Text(customer.alamat),
        ));
  }
}
