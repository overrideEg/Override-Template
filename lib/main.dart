import 'package:ez_localization/ez_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testapp/UI/pages/home_page.dart';
import 'package:testapp/core/services/preference/preference.dart';

import 'core/services/theme/theme_provider.dart';
import 'core/utils/provider_setup.dart';

void main() async {
  await Preference.init();
  runApp(MyApp());
}

// This widget is the root of your application.
class MyApp extends StatelessWidget {
  /*
   * {
   *  "greeting": "Hello {target}, my name is {me} !"
   * }
   * You can then fill them with
   * EzLocalization.of(context).get('greeting', {target: 'John', me: 'Bob'}).
   */
  final ezLocalization = EzLocalizationDelegate(supportedLocales: [Locale('en'), Locale('ar')]);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        home: HomePage(), //Routes.splash,
        title: 'O Template',
        debugShowCheckedModeBanner: false,
        theme: Themes.all[Provider.of<ThemeProvider>(context).themeIndex],
        supportedLocales: ezLocalization.supportedLocales,
        localizationsDelegates: ezLocalization.localizationDelegates,
        localeResolutionCallback: ezLocalization.localeResolutionCallback,
      ),
    );
  }
}
