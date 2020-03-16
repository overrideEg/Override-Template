import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class MovingWidget extends StatefulWidget {
  const MovingWidget({this.child, this.ticker = false, Key key}) : super(key: key);
  final Widget child;
  final bool ticker;

  @override
  _MovingWidgetState createState() => _MovingWidgetState();
}

class _MovingWidgetState extends State<MovingWidget> {
  Ticker ticker;

  @override
  void initState() {
    if (widget.ticker) {
      ticker = Ticker((d) {
        if (mounted) {
          setState(() {});
        }
      });
      ticker.start();
    }
    super.initState();
  }

  @override
  void dispose() {
    if (ticker != null) {
      ticker.stop();
      ticker.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var time = DateTime.now().millisecondsSinceEpoch / 2000;
    var scaleX = 1.2 + sin(time) * .05;
    var scaleY = 1.2 + cos(time) * .07;
    var offsetY = 20 + cos(time) * 20;

    return Transform(
        transform: Matrix4.diagonal3Values(scaleX, scaleY, 1),
        child: Transform.translate(
          offset: Offset(-(scaleX - 1) / 2 * size.width, -(scaleY - 1) / 2 * size.height + offsetY),
          child: widget.child,
        ));
  }
}
