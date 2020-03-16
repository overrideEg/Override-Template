import 'package:flutter/material.dart';
import 'package:testapp/core/models/api_models.dart';
import 'package:testapp/core/services/api/api.dart';
import 'package:testapp/ui/shared/base_notifier.dart';

class CommentsWidgetModel extends BaseNotifier {
  final Post post;
  final Api _api;
  CommentsWidgetModel({@required Api api, @required this.post}) : _api = api;

  List<Comment> comments;

  Future fetchComments() async {
    setBusy(true);
    comments = await _api.getCommentsForPost(post.id);
    setBusy(false);
  }
}
