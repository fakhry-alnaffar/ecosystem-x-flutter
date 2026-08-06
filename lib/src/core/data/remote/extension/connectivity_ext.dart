import 'package:connectivity_plus/connectivity_plus.dart';

extension ConnectivityListExt on List<ConnectivityResult> {
  bool get hasConnection {
    if (isEmpty || contains(ConnectivityResult.none)) return false;
    
    // If the only connection is bluetooth, we assume no internet access
    // unless it's accompanied by other types.
    if (every((result) => result == ConnectivityResult.bluetooth)) return false;
    
    return true;
  }
}
