import 'dart:async';

import 'package:testapp/core/models/api_models.dart';
import 'package:testapp/core/services/api/api.dart';

class AuthenticationService {
  final Api _api;

  AuthenticationService({Api api}) : _api = api;
  Stream<User> get user => _userController.stream;
  StreamController<User> _userController = StreamController<User>();

  Future<bool> login(int userId) async {
    var fetchedUser = await _api.getUser(userId);

    var hasUser = fetchedUser != null;
    if (hasUser) {
      _userController.add(fetchedUser);
    }

    return hasUser;
  }
}
