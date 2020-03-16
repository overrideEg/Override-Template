import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:testapp/core/constants/keys.dart';
import 'package:testapp/core/models/api_models.dart';
import 'package:testapp/core/services/api/api.dart';
import 'package:testapp/ui/routes/route.dart';
import 'package:testapp/ui/shared/base_notifier.dart';
import 'package:testapp/ui/shared/ui.dart';

class HomePageModel extends BaseNotifier {
  final Api _api;
  final Logger _logger;

  final Post post; //ex: passed in construction
  List<Comment> comments;

  HomePageModel({@required Api api, @required Logger logger, this.post})
      : this._api = api,
        this._logger = logger {
    widgetBusy[Keys.comments] = false;
  }

  //operate portion of the UI Screen
  Future<void> fetchComments({postId}) async {
    widgetBusy[Keys.comments] = true;
    notifyListeners();

    comments = await _api.getCommentsForPost(postId);

    widgetBusy[Keys.comments] = false;
    notifyListeners();
  }

  someFunction() async {
    setBusy(true);

    await Future.delayed(Duration(seconds: 11));

    _logger.v("Verbose log ${post.body}");

    _logger.d("Debug log");

    _logger.i("Info log");

    _logger.w("Warning log");

    _logger.e("Error log");

    _logger.wtf("What a terrible failure log");

    setBusy(false);
  }

  doPress(BuildContext context) async {
    var success = await someFunction();
    if (success) {
      UI.push(context, Routes.post(post));
    }
  }
}
