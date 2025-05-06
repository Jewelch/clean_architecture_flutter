import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnecetivityManager {
  final Connectivity connectivity;
  bool _isConnected = true;
  late StreamSubscription<List<ConnectivityResult>> _subscription;

  ConnecetivityManager({required this.connectivity}) {
    _initConnectivity();
    _setupConnectivityListener();
  }

  Future<void> _initConnectivity() async {
    try {
      final results = await connectivity.checkConnectivity();
      _updateConnectionStatus(results);
    } catch (e) {
      _isConnected = false;
    }
  }

  void _setupConnectivityListener() {
    _subscription = connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    // If any connectivity type is available (not none), consider connected
    _isConnected = results.any((result) => result != ConnectivityResult.none);
  }

  // Synchronous getters that use cached connectivity state
  bool get isConnected => _isConnected;

  // Dispose method to clean up resources
  void dispose() {
    _subscription.cancel();
  }

  // Keep these methods for backward compatibility but update them for the new API
  Future<bool> get isWifiConnected async {
    final results = await connectivity.checkConnectivity();
    return results.contains(ConnectivityResult.wifi);
  }

  Future<bool> get isMobileConnected async {
    final results = await connectivity.checkConnectivity();
    return results.contains(ConnectivityResult.mobile);
  }
}
