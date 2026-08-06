//ignore: one_member_abstracts

/// Contract for checking device network reachability.
///
/// Implement this interface to provide a custom connectivity strategy.
/// Two built-in implementations are provided:
/// - [AlwaysHaveConnection] — always returns `true` (useful for web / tests).
/// - [MobileConnectionChecker] — combines OS connectivity state with a live
///   DNS ping for accurate mobile/desktop results.
abstract interface class ConnectionChecker {
  /// Returns `true` if the device currently has network access.
  Future<bool> hasConnection();
}
