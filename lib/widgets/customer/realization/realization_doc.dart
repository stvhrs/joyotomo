import 'package:bitsdojo_window_example/widgets/kop.dart';
import 'package:flutter/material.dart';

import '../../../models/customer.dart';

class RealizationDoc extends StatelessWidget {
  final Customer customer;
  const RealizationDoc({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          body: Container(
            child: Column(
              children: [const Kop(),
                Text(customer.alamat),
              ],
            ),
          ),
        );
  }
}
