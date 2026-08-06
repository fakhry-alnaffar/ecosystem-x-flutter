import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:ecosystem_x_flutter/x_flutter_core.dart';
import 'package:ecosystem_x_flutter/src/core/data/remote/extension/connectivity_ext.dart';

/// A [ConnectionChecker] for mobile and desktop platforms.
///
/// Uses a two-stage check for accuracy without unnecessary network round trips:
/// 1. OS connectivity state via [Connectivity] (fast, no network I/O).
/// 2. Live DNS reachability via [InternetConnection] (only if stage 1 passes).
class MobileConnectionChecker implements ConnectionChecker {
  final InternetConnection _connection;
  final Connectivity _connectivity;

  /// Creates a [MobileConnectionChecker].
  ///
  /// Pass custom [internetConnection] and [connectivity] instances for testing.
  MobileConnectionChecker({
    InternetConnection? internetConnection,
    Connectivity? connectivity,
  })  : _connection = internetConnection ?? InternetConnection(),
        _connectivity = connectivity ?? Connectivity();

  @override
  Future<bool> hasConnection() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (!connectivityResult.hasConnection) return false;
    return _connection.hasInternetAccess;
  }
}
