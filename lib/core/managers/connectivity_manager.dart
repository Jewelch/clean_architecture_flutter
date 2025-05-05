import 'package:connectivity_plus/connectivity_plus.dart';

class ConnecetivityManager {
  final Connectivity connectivity;

  ConnecetivityManager({required this.connectivity});

  bool get isConnected => connectivity.checkConnectivity() != ConnectivityResult.none;

  bool get isWifiConnected => connectivity.checkConnectivity() == ConnectivityResult.wifi;

  bool get isMobileConnected => connectivity.checkConnectivity() == ConnectivityResult.mobile;
}
