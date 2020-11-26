import 'package:flutter/material.dart';
import 'package:testapp/core/models/api_models.dart';
import 'package:testapp/ui/pages/home_page.dart';
import 'package:testapp/ui/pages/post_page/post_page.dart';

class Routes {
  static Widget current;

  static Widget _setRoute(Widget route) {
    current = route;
    return route;
  }

  static Widget get homePage => _setRoute(HomePage());

  static Widget post(Post post) => _setRoute(PostPage(post: post));
}
