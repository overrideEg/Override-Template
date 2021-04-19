import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:testapp/core/models/api_models.dart';
import 'package:ui_utils/ui_utils.dart';

import '../../../ui/routes/route.dart';
import '../api/http_api.dart';
import '../preference/preference.dart';

class AuthenticationService {
  final HttpApi? api;
  AuthenticationService({this.api});

  User? _user;
  User? get user => _user;

  /*
  * Sign up user 
  */
  // Future<void> signUp({String fullName, String email, String password}) async {
  //   try {
  //     _user = null; //🦄TODO signUp implementation
  //     if (_user != null) {
  //       // Logger().i(_user.toJson());
  //       saveUser(user: _user);
  //       saveUserToken(token: _user.token);
  //     }
  //   } catch (e) {
  //     Logger().e(e);
  //   }
  // }

  // signUp(BuildContext context, {Map<String, dynamic> body}) async {
  //   var res = await api.signUp(context, body: body);
  //   bool result = false;
  //   User user;
  //   print("===> ${res.toString()}");
  //   res.fold((error) => errorDialog(context, error: error.toString()), (data) {
  //     if (data != null) {
  //       user = User.fromJson(data);
  //       saveUser(user: user);
  //       updateUserFcm(context, userId: user.user.id);
  //       UI.toast("Success");
  //     }
  //     result = true;
  //   });
  //   return result;
  // }

  signIn(BuildContext context, {required Map<String, dynamic> body}) async {
    var res = await api!.signIn(context, body: body);
    bool result = false;
    User user;
    print("===> ${res.toString()}");
    res.fold((error) => UI.toast(error.toString()), (data) {
      print(data["message"]);
      if (data != null) {
        user = User.fromJson(data);
        saveUser(user: user);
        updateUserFcm(context, userId: user.user!.sId!);
        // UI.toast("Success");
      }
      result = true;
    });
    return result;
  }

  signOut() {
    Preference.clear();
    _user = null;
  }

  updateUserFcm(BuildContext context, {required String userId}) async {
    Map<String, dynamic> body = {
      "fcmToken": Preference.getString(PrefKeys.fcmToken),
    };
    var res = await api!.updateFcmToken(context, body: body, userId: userId);
    UserInfo us;
    res.fold((error) => UI.dialog(msg: error.toString()), (data) {
      print(data);
      us = UserInfo.fromJson(data);
      if (us != null) {
        _user!.user = us;
        saveUser(user: _user!);
        print("FCM Updated:  ${Preference.getString(PrefKeys.fcmToken)}");
      }
    });
  }

  saveUser({required User user}) {
    Preference.setBool(PrefKeys.userLogged, user.user!.isActive ?? false);
    Preference.setString(PrefKeys.userData, json.encode(user.toJson()));
    Preference.setString(PrefKeys.token, user.token!);
    Preference.setString(PrefKeys.fcmToken, user.user!.fcmToken!);
    _user = user;
  }

  bool get userLoged => Preference.getBool(PrefKeys.userLogged) ?? false;

  Future<void> get loadUser async {
    if (userLoged) {
      _user =
          User.fromJson(json.decode(Preference.getString(PrefKeys.userData)!));
      Logger().i(_user!.toJson());
    }
  }
}
