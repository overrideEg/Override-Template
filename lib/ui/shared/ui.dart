/*
 * @desc [class that will hold most of the reusable UI components and operators like textStyles and Dialogs]
 */
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';

class UI {
  static Future<dynamic> push(BuildContext context, Widget page, {PageTransitionType transitionType = PageTransitionType.fade, bool replace = false, int duration = 1000, int delay}) async {
    if (delay != null) await Future.delayed(Duration(milliseconds: delay), () {});
    final pageTransition = PageTransition(type: transitionType, child: page, duration: Duration(milliseconds: duration));
    return replace ? await Navigator.pushReplacement(context, pageTransition) : await Navigator.push(context, pageTransition);
  }

  //TODO refactor
  static Future<dynamic> dialog({BuildContext context, Widget child, bool accept, String title, String msg, String acceptMsg, String cancelMsg}) async {
    return await showDialog<dynamic>(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              padding: EdgeInsets.all(4),
              // decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(10),
              //     color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (child != null) child,
                  if (title != null)
                    Text(
                      title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  if (msg != null)
                    Text(
                      msg,
                      maxLines: 2,
                      style: TextStyle(fontSize: 12),
                    ),
                  SizedBox(height: 5),
                  if (accept != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        InkWell(
                          onTap: () => Navigator.of(context).pop(false),
                          child: Container(
                              alignment: Alignment.center,
                              height: 32,
                              width: 90,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.teal[700]),
                              child: Text(
                                cancelMsg,
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                        InkWell(
                          onTap: () => Navigator.of(context).pop(true),
                          child: Container(
                              alignment: Alignment.center,
                              height: 32,
                              width: 90,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.teal[700]),
                              child: Text(
                                acceptMsg,
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      ],
                    )
                ],
              ),
            ),
          );
        });
  }

  static toast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      fontSize: 15.0,
      timeInSecForIos: 1,
      textColor: Colors.white,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Colors.grey[700],
    );
  }

  // static Future<dynamic> radioDialog({BuildContext context, String label, Widget child}) async {
  //   return await showDialog<dynamic>(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (context) {
  //         return new AlertDialog(
  //           contentPadding: const EdgeInsets.all(16.0),
  //           content: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: <Widget>[
  //               if (label != null) Text(label, style: UI.textStyleNormal()),
  //               child,
  //             ],
  //           ),
  //         );
  //       });
  // }

  // static Future<dynamic> dialog(
  //     BuildContext context, Widget child, String title, String msg, String buttonMsg) {
  //   var alert = Stack(alignment: Alignment.center, children: <Widget>[
  //     AlertDialog(
  //       content: Container(
  //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           children: <Widget>[
  //             child,
  //             Text(
  //               title,
  //               style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
  //             ),
  //             Text(
  //               msg,
  //               maxLines: 2,
  //               style: TextStyle(fontSize: 12),
  //             ),
  //             SizedBox(height: 5),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               children: <Widget>[
  //                 InkWell(
  //                   onTap: () => Navigator.of(context).pop(false),
  //                   child: Container(
  //                       alignment: Alignment.center,
  //                       height: 32,
  //                       width: 90,
  //                       decoration:
  //                           BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.teal[700]),
  //                       child: Text(
  //                         'close',
  //                         style: TextStyle(color: Colors.white),
  //                       )),
  //                 ),
  //               ],
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   ]);

  //   return showDialog(context: context, barrierDismissible: false, builder: (context) => alert);
  // }

}
