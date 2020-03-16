import 'package:flutter/material.dart';
import 'package:testapp/UI/responsive/screen_utill.dart';

import 'floating_widget.dart';
import 'image_button.dart';

class DisconnectedWidget extends StatelessWidget {
  final double height;
  final double padding;
  final Function onPressed;
  const DisconnectedWidget({this.height = 800, this.padding = 500, this.onPressed, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final portrait = ScreenUtil.portrait;
    return Padding(
      padding: EdgeInsets.only(top: padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: ScreenUtil.height(portrait ? height : height / 1.05),
            decoration: BoxDecoration(color: Colors.grey.withOpacity(.3), shape: BoxShape.circle),
            child: FloatingWidget(
              child: Text('data'),
            ),
          ),
          Text('لا يوجد إتصال بالشبكة', style: TextStyle(color: Colors.grey[600], fontSize: portrait ? 32 : 28, fontWeight: FontWeight.bold)),
          Text('تأكد من إتصالك بالشبكة و اعد المحاولة', style: Theme.of(context).textTheme.button.copyWith(color: Colors.black38)),
          if (portrait) const SizedBox(height: 12),
          Padding(
            padding: EdgeInsets.only(bottom: portrait ? 20 : 0),
            child: ImageButton(
              // width: portrait ? null : ScreenUtil.width(300),
              onPressed: onPressed,
              background: Text('background'),
              highlightColor: Colors.white,
              child: Center(child: Text('حاول مجددا', style: Theme.of(context).textTheme.body2)),
            ),
          ),
        ],
      ),
    );
  }
}
