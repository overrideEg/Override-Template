import 'package:flutter/material.dart';

class FloatingWidget extends StatefulWidget {
  FloatingWidget({@required this.child, this.begin = const Offset(0.0, 0.02), this.end = const Offset(0.0, -0.05), this.durationMilli = 3000, Key key}) : super(key: key);
  final Offset end;
  final Offset begin;
  final Widget child;
  final int durationMilli;

  @override
  _FloatingWidgetState createState() => _FloatingWidgetState();
}

class _FloatingWidgetState extends State<FloatingWidget> with SingleTickerProviderStateMixin {
  AnimationController slideController;
  Animation<Offset> slideAnimation;

  @override
  void initState() {
    slideController = AnimationController(duration: Duration(milliseconds: widget.durationMilli), vsync: this)
      ..addListener(() {
        setState(() {});
      });
    slideAnimation = Tween<Offset>(begin: widget.begin, end: widget.end).animate(CurvedAnimation(parent: slideController, curve: Curves.ease));
    slideController.repeat(reverse: true);

    super.initState();
  }

  @override
  void dispose() {
    slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: slideAnimation,
      child: widget.child,
    );
  }
}
