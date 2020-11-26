import 'dart:async';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../auth/authentication_service.dart';

//inetiated at the app start to listen to notifications..
class NotificationService {
  bool _isSettedUp = false;

  final AuthenticationService auth;
  List<dynamic> userNotifications;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  NotificationService({this.auth});

  Future<void> init(context) async {
    if (!_isSettedUp) {
      _isSettedUp = true;

      String token = await _firebaseMessaging.getToken();
      print("Firebase token : $token");

      _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print("onMessage : $message");
          operateMessage(message);
        },
        onResume: (Map<String, dynamic> message) async {
          operateMessage(message);
          print("onResume : $message");
        },
        onLaunch: (Map<String, dynamic> message) async {
          operateMessage(message);
          print("onLunch : $message");
        },
      );

      if (Platform.isIOS) await getIOSPermission();

      await _firebaseMessaging.getToken().then(updateFCMToken);

      await getNotifications();
    }
  }

  Future<void> getNotifications() async {
    try {
      // userNotifications = await auth.api.getNotifications(userId: auth.user.id, lastId: null);
      // if (userNotifications != null && userNotifications.isNotEmpty) {
      //   final newestNotification = userNotifications.first;
      //   Preference.setInt(PrefKeys.newestNotificationId, newestNotification.id);
      //   print('updated new notification ${newestNotification.id}');
      //   print('last notification ${Preference.getInt(PrefKeys.lastSeenNotificationId)}');
      // }
    } catch (e) {
      print('failed to update last notification $e');
    }
  }

  Future<void> updateFCMToken(token) async {
    if (token != null) {
      try {
        // auth.updateUserFcm(fcmToken: token);
        // Preference.setString(PrefKeys.fcmToken, token);

        // print('new fcm:$token');
      } catch (e) {
        print('error updating fcm');
      }
    }
  }

  Future handleNotification(context) async {
    // User user;
    // user = Provider.of<UserProvider>(context, listen: false).user;
    // List<NotificationItem> items = await Api.instance.getNotifications(page: 1, userID: user.id, token: user.accessToken, length: 100);
    // for (NotificationItem item in items) {
    //   NotificationItem temp = await DB.notificationItemDAO.findItemByID(item.id);
    //   if (temp == null) {
    //     await DB.notificationItemDAO.insertItem(item..isSeen = false);
    //   }
    // }
  }

  operateMessage(Map<String, dynamic> message, {bool showOverlay = true}) async {
    String body;
    String title;
    Map<dynamic, dynamic> data;
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isIOS && int.parse((await deviceInfo.iosInfo).systemVersion.split('.')[0]) < 13) {
      final messageData = message['aps']['alert'];
      title = messageData['title'];
      body = messageData['body'];
      data = message['data'];
    } else {
      final messageData = message['notification'];
      title = messageData['title'];
      body = messageData['body'];
      data = message['data'];
    }
    // Preference.setInt(PrefKeys.newestNotificationId, (Preference.getInt(PrefKeys.newestNotificationId) ?? 0) + 1);

    if (showOverlay) {
      // showOverlayNotification((context) {
      // return Notify(title: title, body: body, data: data);
      // }, duration: Duration(seconds: 4));
    }

    // try {
    //   final notificationItem = NotificationItem.fromJson(message['data']);
    //   if (notificationItem.offerId != null) navigateToOffer(notificationItem.offerId);
    // } catch (e) {
    //   print('\n\n operateMessage ERROR:' + e.toString() + '\n\n');
    // }
  }

  getIOSPermission() async {
    await _firebaseMessaging
        .requestNotificationPermissions(const IosNotificationSettings(sound: true, badge: true, alert: true, provisional: true));

    // final iosSubscription = _firebaseMessaging.onIosSettingsRegistered.listen((data) {
    //       _saveDeviceToken();
    //     });
  }
}
