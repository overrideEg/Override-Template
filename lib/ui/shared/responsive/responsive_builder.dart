import 'package:flutter/material.dart';
import 'package:testapp/core/utils/screen_utill.dart';

import 'sizing_information.dart';

class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, SizingInformation sizingInformation) builder;
  const ResponsiveBuilder({Key key, this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return LayoutBuilder(builder: (context, boxConstraints) {
      final sizingInformation = SizingInformation(
        screenSize: mediaQuery.size,
        deviceScreenType: ScreenUtil.getDeviceType(mediaQuery),
        localWidgetSize: Size(boxConstraints.maxWidth, boxConstraints.maxHeight),
      );

      return builder(context, sizingInformation);
    });
  }
}
