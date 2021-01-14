import 'dart:async';

import 'package:get/get.dart';
import 'package:testapp/core/models/api_models.dart';
import 'package:testapp/core/services/api/api.dart';
import 'package:testapp/core/services/api/http_api.dart';

class AuthenticationService {
  final HttpApi _api = Get.find();

  User _user;
  User get user => _user;

  // AuthenticationService();

  Future<bool> login(int userId) async {
    var fetchedUser = await _api.getUser(userId);

    if (fetchedUser != null) {
      _user = fetchedUser;
    }

    // if (hasUser) {
    //   _userController.add(fetchedUser);
    // }

    return fetchedUser != null ? true : false;
  }
}
