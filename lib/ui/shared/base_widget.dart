import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testapp/core/utils/screen_utill.dart';

class BaseWidget<T extends ChangeNotifier> extends StatefulWidget {
  final T model;
  final Widget child;
  final Function(T) onModelReady;
  final Widget Function(BuildContext context, T value, Widget child) builder;

  BaseWidget({Key key, this.model, this.builder, this.onModelReady, this.child}) : super(key: key);

  _BaseWidgetState<T> createState() => _BaseWidgetState<T>();
}

class _BaseWidgetState<T extends ChangeNotifier> extends State<BaseWidget<T>> {
  // We want to store the instance of the model in the state
  // that way it stays constant through rebuilds
  T model;

  @override
  void initState() {
    // assign the model once when state is initialised
    model = widget.model;
    if (widget.onModelReady != null) {
      widget.onModelReady(model);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return ChangeNotifierProvider<T>(
      create: (context) => model,
      child: Consumer<T>(
        child: widget.child,
        builder: widget.builder,
      ),
    );
  }
}
