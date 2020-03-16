// provider_setup.dart
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:testapp/core/models/api_models.dart';
import 'package:testapp/core/services/api/api.dart';
import 'package:testapp/core/services/api/fake_api.dart';
import 'package:testapp/core/services/api/http_api.dart';
import 'package:testapp/core/services/auth/authentication_service.dart';
import 'package:testapp/core/services/database/database.dart';
import 'package:testapp/core/services/theme/theme_provider.dart';

const bool USE_FAKE_IMPLEMENTATION = true;

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders,
];

List<SingleChildWidget> independentServices = [
  Provider(create: (_) => () => DB()),
  Provider(create: (_) => () => Logger()),
  Provider(create: (_) => () => USE_FAKE_IMPLEMENTATION ? FakeApi() : HttpApi()),
];

List<SingleChildWidget> dependentServices = [
  ProxyProvider<Api, AuthenticationService>(update: (context, api, authenticationService) => AuthenticationService(api: api)),
];

List<SingleChildWidget> uiConsumableProviders = [
  ChangeNotifierProvider(create: (_) => ThemeProvider()),
  StreamProvider<User>(create: (context) => Provider.of<AuthenticationService>(context, listen: false).user),
];
