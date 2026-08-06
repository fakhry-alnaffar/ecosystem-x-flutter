import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Convenience extensions on [num] for adaptive sizing via ScreenUtil.
/// Using [num] (not [int] or [double]) keeps these available on any
/// numeric literal or variable without explicit casts.
extension ScreenMetrics on num {
  double get aw => toDouble().w;
  double get ah => toDouble().h;
  double get asp => toDouble().sp;
  double get ar => toDouble().r;
}
