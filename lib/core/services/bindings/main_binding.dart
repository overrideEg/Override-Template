import 'package:get/get.dart';
import 'package:testapp/core/services/api/api.dart';
import 'package:testapp/core/services/api/http_api.dart';
import 'package:testapp/core/services/auth/authentication_service.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HttpApi(), permanent: true);
    Get.put(AuthenticationService(), permanent: true);
  }
}
