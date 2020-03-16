import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';

class ConnectivityService extends ChangeNotifier {
  bool lowApi = false;

  bool _connected = true;
  bool get connected => _connected;

  StreamSubscription<ConnectivityResult> subscription;
  ConnectivityService() {
    init();
  }

  Future<void> init() async {
    // ConnectivityResult connectivityResult = await (Connectivity().checkConnectivity());
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // print('connectivity from listner');
      if (result == ConnectivityResult.none) {
        _connected = false;
      } else if (_connected == false) {
        _connected = true;
        notifyListeners();
      }
    });

    //check API LEVEL
    if (Platform.isAndroid) {
      // var model = androidInfo.model;
      // var release = androidInfo.version.release;
      // var manufacturer = androidInfo.manufacturer;
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      final apiLEVEL = androidInfo.version.sdkInt;
      if (apiLEVEL < 20) lowApi = true;
    }
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }
}
