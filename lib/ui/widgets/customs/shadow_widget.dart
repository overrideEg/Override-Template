import 'package:flutter/material.dart';

class ShadowWidget extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  final double blrRadius;
  final double spreadRadius;

  const ShadowWidget({
    Key key,
    this.blrRadius,
    this.width,
    this.height,
    this.child,
    this.spreadRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? null,
      width: width ?? null,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: blrRadius ?? 20.0, // has the effect of softening the shadow
            spreadRadius: spreadRadius ?? 5.0, // has the effect of extending the shadow
            offset: Offset(.0, -0.1),
          )
        ],
      ),
      child: child,
    );
  }
}
