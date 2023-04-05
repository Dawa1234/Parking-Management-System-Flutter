import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkConnection {
  static Future<bool> isOnline() async {
    bool isOnline = false;
    try {
      var connectionResult = await Connectivity().checkConnectivity();
      if (connectionResult == ConnectivityResult.mobile ||
          connectionResult == ConnectivityResult.wifi) {
        isOnline = true;
        return isOnline;
      }
      return isOnline;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
