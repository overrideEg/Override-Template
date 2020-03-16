import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testapp/core/page%20models/home_page_model.dart';
import 'package:testapp/core/utils/base_widget.dart';
import 'package:testapp/ui/shared/styles/colors.dart';
import 'package:testapp/ui/widgets/comment_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<HomePageModel>(
      model: HomePageModel(api: Provider.of(context), logger: Provider.of(context)),
      child: Text("this widget will not get rerendered over setStates"),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: AppColors.primaryBackground,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              model.busy
                  ? CircularProgressIndicator()
                  : FlatButton(
                      color: Colors.white,
                      child: Text(
                        'Home',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: model.doPress(context),
                    ),
              CommentsWidgetWithInnerLogic(post: model.post)
            ],
          ),
        );
      },
    );
  }
}
