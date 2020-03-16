import 'package:ez_localization/ez_localization.dart';
import 'package:flutter/material.dart';
import 'package:testapp/ui/shared/styles/colors.dart';

class NormalButton extends StatelessWidget {
  final bool localize;
  final double width;
  final double height;
  final String text;
  final EdgeInsets margin;
  final Function onPressed;
  const NormalButton({Key key, this.localize = true, this.onPressed, this.text = 'ok', this.width = 322, this.height = 46, this.margin = const EdgeInsets.only(top: 22)}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = EzLocalization.of(context);

    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: EdgeInsets.all(0),
      child: FlatButton(
        onPressed: onPressed,
        color: AppColors.secondaryElement,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(23)),
        ),
        textColor: Colors.white,
        // padding: EdgeInsets.all(0),
        child: Text(localize ? locale.get(text) : text, textAlign: TextAlign.center, style: TextStyle(color: AppColors.accentText, fontWeight: FontWeight.w400, fontSize: 20)),
      ),
    );
  }
}
