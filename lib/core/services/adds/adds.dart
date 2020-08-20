import 'dart:io';

// <manifest>
//     <application>
//         <meta-data
//             android:name="com.google.android.gms.ads.APPLICATION_ID"
//             android:value="ca-app-pub-################~##########"/>  ~~~Replace with your real AdMob app ID
//     </application>
// </manifest>

// Info.plist changes
// Admob requires the App ID to be included in Info.plist.

// <key>GADApplicationIdentifier</key>
// <string>[ADMOB_APP_ID]</string>

class AddsService {
  static String get appId {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544~1458002511';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-2371248747511613~4363131048';
    }
    return null;
  }

  static String get homeBannerAdUnitId1 {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-2371248747511613/2587014947';
    }
    return null;
  }
}
