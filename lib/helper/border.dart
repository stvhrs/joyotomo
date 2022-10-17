import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Kotak extends StatelessWidget {
  final Widget child;
  final double height;
  final double width;
  const Kotak(
      {super.key,
      required this.child,
      required this.height,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(margin: EdgeInsets.zero,
      height: height,
      width: width,
      decoration: BoxDecoration(border: Border.all()),
      child: child,
    );
  }
}
