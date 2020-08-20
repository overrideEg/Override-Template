import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:testapp/core/services/adds/adds.dart';
import 'package:testapp/core/services/preference/preference.dart';

import 'core/services/localization/localization.dart';
import 'core/services/theme/theme_provider.dart';
import 'core/utils/provider_setup.dart';
import 'ui/routes/route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Admob.initialize(AddsService.appId);
  await Preference.init();

  runApp(MyApp());
}

// This widget is the root of your application.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MultiProvider(
        providers: providers,
        child: Consumer2<AppLanguageModel, ThemeProvider>(
          builder: (context, language, theme, child) {
            return MaterialApp(
              home: Routes.homePage,
              debugShowCheckedModeBanner: false,
              theme: theme.isDark ? theme.dark : theme.light,
              locale: language.appLocal,
              supportedLocales: [const Locale('en'), const Locale('ar')],
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
            );
          },
        ),
      ),
    );
  }
}
