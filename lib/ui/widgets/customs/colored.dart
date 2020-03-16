import 'package:flutter/material.dart';

class Colored extends StatelessWidget {
  final Widget child;
  final Color color;
  const Colored({Key key, this.child, this.color = const Color.fromRGBO(255, 255, 255, 0.2)}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(colorFilter: ColorFilter.mode(color, BlendMode.color), child: child);
  }

  // Colored(99, 164, 0, child: MovingWidget(child: Image.asset('assets/images/Bg-Blue.png', fit: BoxFit.cover))), example
}
