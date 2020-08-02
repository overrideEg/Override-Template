import 'package:base_notifier/base_notifier.dart';
import 'package:flutter/material.dart';
import 'package:testapp/core/page_models/post_page_model.dart';

class PostContentWidget extends StatelessWidget {
  const PostContentWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<PostPageModel>.cosnume(
      builder: (context, model, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              'last widget render at: ${DateTime.now().toString()}',
              textAlign: TextAlign.center,
            ),
            Container(
              height: 200,
              child: model.busy ? loadingWidget() : dataWidget(context, model),
            ),
          ],
        );
      },
    );
  }

  loadingWidget() => Container(height: 66, width: 66, child: Center(child: CircularProgressIndicator()));

  dataWidget(BuildContext context, PostPageModel model) {
    if (model.state == NotifierState.error) {
      return Text('error retreving data');
    } else {
      return ListView.builder(itemBuilder: (context, index) {
        return RaisedButton(
          onPressed: () => {},
          child: Text('post comments'),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          color: Colors.blue,
        );
      });
    }
  }
}
