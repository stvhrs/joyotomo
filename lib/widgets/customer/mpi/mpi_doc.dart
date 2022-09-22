import 'package:flutter/material.dart';

import '../../../models/customer.dart';

class MpiDoc extends StatelessWidget {
  final Customer customer;
  const MpiDoc({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: customer,
        child: Container(
          child: Text(customer.alamat),
        ));
  }
}
