import 'package:flutter/material.dart';

class Curved extends StatelessWidget {
  final child;
  const Curved({this.child, Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) => ClipShadowPath(clipper: RoundedClipper(), shadow: Shadow(blurRadius: 5), child: child);

  // ClipPath(child: child, clipper: RoundedClipper());
}

class RoundedClipper extends CustomClipper<Path> {
  final arcHeight;
  RoundedClipper({this.arcHeight = 30});

  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - arcHeight);
    path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height - arcHeight);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

@immutable
class ClipShadowPath extends StatelessWidget {
  final Shadow shadow;
  final CustomClipper<Path> clipper;
  final Widget child;

  ClipShadowPath({
    @required this.shadow,
    @required this.clipper,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ClipShadowShadowPainter(
        clipper: this.clipper,
        shadow: this.shadow,
      ),
      child: ClipPath(child: child, clipper: this.clipper),
    );
  }
}

class _ClipShadowShadowPainter extends CustomPainter {
  final Shadow shadow;
  final CustomClipper<Path> clipper;

  _ClipShadowShadowPainter({@required this.shadow, @required this.clipper});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = shadow.toPaint();
    var clipPath = clipper.getClip(size);
    canvas.drawPath(clipPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
