import 'package:flutter/material.dart';
import 'package:testapp/UI/responsive/screen_utill.dart';

class ImageButton extends StatelessWidget {
  final width;
  final height;
  final Widget background;
  final child;
  final Color splashColor;
  final Color highlightColor;
  final Function onPressed;

  const ImageButton({this.height = 135, this.background, this.child, this.highlightColor = Colors.white10, this.splashColor = Colors.white, this.width = 420, this.onPressed, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      height: ScreenUtil.height(height),
      width: ScreenUtil.width(width),
      child: RaisedButton(
        padding: EdgeInsets.all(0),
        elevation: 7,
        clipBehavior: Clip.antiAlias,
        child: Stack(fit: StackFit.expand, alignment: Alignment.center, children: <Widget>[
          Positioned.fill(child: background),
          Center(child: child),
          Positioned.fill(
              child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: splashColor.withOpacity(.1),
                    highlightColor: highlightColor.withOpacity(.1),
                    onTap: onPressed,
                  ))),
        ]),
        onPressed: () {},
      ),
    );
  }
}
