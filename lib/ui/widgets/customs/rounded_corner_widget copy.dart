import 'package:flutter/material.dart';

class RoundedWidget extends StatelessWidget {
  final Widget child;
  final double raduis;
  const RoundedWidget({Key key, this.child, this.raduis}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(raduis ?? 10), child: child);
  }
}
