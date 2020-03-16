import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationType {}

//inetiated at the app start to listen to notifications..
class FirebaseNotifications {
  static FirebaseMessaging _firebaseMessaging;

  ///made to not everytime restart app the notification is setted up again
  static bool _isSettedUp = false;
  static setUpListeners(context) {
    if (_isSettedUp) {
      return;
    }
    _isSettedUp = true;
    _firebaseMessaging = FirebaseMessaging();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        await _handleNotification(context);
        operateMessage(message);
      },
      onResume: (Map<String, dynamic> message) async {
        operateMessage(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        operateMessage(message);
      },
    );

    if (Platform.isIOS) getIOSPermission();

    _firebaseMessaging.getToken().then((token) {
      // token.log(title: 'fCM token');
      // Prefrence.setString(PrefKeys.gcmToken, token);
    });
  }

  static Future _handleNotification(context) async {}

  static operateMessage(Map<String, dynamic> message) {
    try {
      // final notificationItem = NotificationItem.fromJson(message['data']);
      // if (notificationItem.offerId != null) navigateToOffer(notificationItem.offerId);
    } catch (e) {
      print('\n\n operateMessage ERROR:' + e.toString() + '\n\n');
    }
  }

  static navigateToOffer(int offerID) async {
    /**
     * TO Test use this Post Request
     * URL:https://fcm.googleapis.com/fcm/send
     * 
     * Header [{"key":"Content-Type","value":"application/json"]
     * Header [{"key":"Authorization","value":" key=AAAAitv8Q7k:APA91bE8Bmf_I1EL1UdkKN2qu29CjUdidTUf9B80rtWT4YmZl4tDzfuH2bvYjeS-ugRhL_XJON9xcZ2yr9_PG_9eLvEk2DU44pMaAGjdwHGi6IplcrRYBLtT78v9rXL39KKTSWEX86GO"]
     * Body {
              "notification": {"title": "50% OFF !","body": "Save 50% on selected items","name":"petsooq","image":"PETSOOQ IMAGEURL"},
              "priority": "high",
              "data": {"click_action": "FLUTTER_NOTIFICATION_CLICK","offer_id":1,"title": "50% OFF !","body": "Save 50% on selected items"},
              "to": "Current FCM TOKEN"
            }
     */

    try {
      // if (homePage.homeContext == null) {
      //   print('context is null trying again in 2 seconds');
      //   await Future.delayed(Duration(seconds: 2), () => navigateToOffer(offerID));
      // } else {
      //   // Navigator.push(context, shahset el items)
      //   //TODO open Items page and fetch items with the given offer id (paginated)

      // }
    } catch (e) {
      print('\n\nnavigateToCall Error: ' + e.toString() + '\n\n');
    }
  }

  static getIOSPermission() {
    _firebaseMessaging.requestNotificationPermissions(const IosNotificationSettings(sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings) => print('IOS Notification Settings registered: $settings'));
  }
}
