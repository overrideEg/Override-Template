import 'dart:async';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../auth/authentication_service.dart';

/*
* 🦄initiated at the app start to listen to notifications..
*/
class NotificationService {
  final AuthenticationService auth;
  List<dynamic> userNotifications;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  NotificationService({this.auth});

  Future<void> init(context) async {
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
  }

  Future<void> updateFCMToken(token) async {
    if (token != null) {
      try {
        //TODO update fcm implementation
        // Preference.setString(PrefKeys.fcmToken, token);

        // print('new fcm:$token');
      } catch (e) {
        print('error updating fcm');
      }
    }
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

    //TODO implement behavior
  }

  getIOSPermission() async {
    await _firebaseMessaging
        .requestNotificationPermissions(const IosNotificationSettings(sound: true, badge: true, alert: true, provisional: true));

    // final iosSubscription = _firebaseMessaging.onIosSettingsRegistered.listen((data) {
    //       _saveDeviceToken();
    //     });
  }
}
