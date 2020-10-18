import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:testapp/core/models/api_models.dart';

class RequestType {
  static const String Get = 'get';
  static const String Post = 'post';
  static const String Put = 'put';
  static const String Delete = 'delete';
}

class Header {
  static Map<String, dynamic> clientAuth({@required String clientID}) {
    final hashedClient = const Base64Encoder().convert("$clientID:".codeUnits);
    return {'Authorization': 'Basic $hashedClient'};
  }

  static Map<String, dynamic> userAuth(String accessToken) => {'Authorization': 'Bearer $accessToken'};
}

class EndPoint {
  static const String REGISTER = 'register';
  static const String TOKEN = 'auth/token';
  static const String USER = 'user';
  static const String POST = 'post';
  static const String COMMENT = 'comment';
  static const String REPLY = 'reply';
}

abstract class Api {
  Future<LoginResponse> login({String username, String password});

  Future<User> getUser(int userId);

  Future<List<Post>> getPostsForUser(int userId);

  Future<List<Comment>> getCommentsForPost(int postId);
}
