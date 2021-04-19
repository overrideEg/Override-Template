import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:testapp/core/models/api_models.dart';
import 'package:testapp/core/models/server_error.dart';
import 'package:testapp/core/services/preference/preference.dart';

class RequestType {
  static const String Get = 'get';
  static const String Post = 'post';
  static const String Put = 'put';
  static const String Delete = 'delete';
}

class Header {
  // static Map<String, dynamic> clientAuth({@required String clientID}) {
  //   final hashedClient = const Base64Encoder().convert("$clientID:".codeUnits);
  //   return {'Authorization': 'Basic $hashedClient'};
  // }

  static Map<String, dynamic> get clientAuth => {'Authorization': ''};

  static Map<String, dynamic> get userAuth =>
      {'Authorization': 'Bearer ${Preference.getString(PrefKeys.fcmToken)}'};
}

class EndPoint {
  static const String REGISTER = 'register';
  static const String REQUEST_TOKEN = 'auth/requestToken';
  static const String USER = 'User';
  static const String HOME = 'Home/all';
  static const String RESEND_CODE = 'auth/resendActiveCode';
  static const String ONBOARDING = 'onBoarding/all';
  static const String VERIFY_USER = 'auth/changeStatus';
  static const String POST = 'post';
  static const String COMMENT = 'comment';
  static const String CONTACTUS = 'ContactUs';
  static const String AUTH = 'auth/loginMobile';
  static const String REPLY = 'reply';
  static const String ADDADDRESS = 'User/addAddress';
  static const String GETADDRESSES = 'User/getAddress';
  static const String REMOVEADDREESS = 'User/remove/address/';
  static const String UPLOAD_IMAGE = 'File/upload';
  static const String UPLOAD_MULTIPLE_IMAGE = 'File/uploadMultiple';
  static const String SEARCHUTILITY = 'Utility/search';
  static const String ALLUTILITY = 'Utility/all';
  static const String UTILITYBYSUBCATEGORY = 'Utility/subcategory/';
  static const String OURCONTACT = 'OurContact/all';
  static const String CONTRACT_REQUEST = 'ContractRequest';
  static const String MY_ORDERS = 'ContractRequest/myOrder';
  static const String UPDATE_FCM = 'User/updateFcm';
  static const String REFRESH_TOKEN = 'auth/refreshToken';
  static const String NOTIFICATION = 'Notification';
}

abstract class Api {}
