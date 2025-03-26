import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  @override
  Future<bool> get isConnected async {
    try {
      // ✅ Step 1: Check network type (WiFi, Mobile, None)
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) return false;

      // ✅ Step 2: Try a quick lookup (with a timeout)
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 2), onTimeout: () => []);

      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e) {
      return false; // ✅ Fail-safe: Assume no internet if error occurs
    }
  }
}
