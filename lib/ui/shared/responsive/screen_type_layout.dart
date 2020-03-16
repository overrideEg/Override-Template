import 'package:flutter/material.dart';
import 'package:testapp/core/utils/screen_utill.dart';

import 'responsive_builder.dart';

class ScreenTypeLayout extends StatelessWidget {
  // Mobile will be returned by default
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const ScreenTypeLayout({Key key, @required this.mobile, this.tablet, this.desktop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      switch (sizingInformation.deviceScreenType) {
        case DeviceScreenType.Desktop: // If sizing indicates desktop and we have a desktop widget then return
          return desktop ?? mobile;
          break;
        case DeviceScreenType.Tablet: // If sizing indicates Tablet and we have a tablet widget then return
          return tablet ?? mobile;
          break;
        default: // Return mobile layout if nothing else is supplied
          return mobile;
      }
    });
  }
}
