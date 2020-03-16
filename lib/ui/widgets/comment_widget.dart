import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testapp/core/models/api_models.dart';
import 'package:testapp/core/page%20models/comments_widget_model.dart';
import 'package:testapp/ui/shared/base_widget.dart';
import 'package:testapp/ui/shared/styles/colors.dart';

class CommentsWidgetWithInnerLogic extends StatelessWidget {
  final Post post;
  const CommentsWidgetWithInnerLogic({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<CommentsWidgetModel>(
        onModelReady: (model) => model.fetchComments(),
        model: CommentsWidgetModel(api: Provider.of(context), post: this.post),
        builder: (context, model, child) => model.busy
            ? Center(child: CircularProgressIndicator())
            : Expanded(
                child: ListView.builder(
                  itemCount: model.comments.length,
                  itemBuilder: (context, index) => CommentItem(model.comments[index]),
                ),
              ));
  }
}

/// Renders a single comment given a comment model
class CommentItem extends StatelessWidget {
  final Comment comment;
  const CommentItem(this.comment);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: AppColors.accentText),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            comment.body,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(comment.body + '🍉'),
        ],
      ),
    );
  }
}
