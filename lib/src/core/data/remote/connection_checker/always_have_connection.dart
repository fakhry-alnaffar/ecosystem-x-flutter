import 'package:ecosystem_x_flutter/x_flutter_core.dart';

/// A [ConnectionChecker] that always reports an active connection.
///
/// Use this stub on Flutter Web (where `connectivity_plus` DNS checks are
/// unavailable) or in unit tests where network state should not affect results.
class AlwaysHaveConnection implements ConnectionChecker {
  /// Creates an [AlwaysHaveConnection] stub.
  const AlwaysHaveConnection();

  /// Always returns `true`.
  @override
  Future<bool> hasConnection() => Future.value(true);
}
