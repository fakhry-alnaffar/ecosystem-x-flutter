import 'package:flutter/foundation.dart';

@immutable
class GeoEntity {
  final double lat;
  final double lng;

  const GeoEntity({
    required this.lat,
    required this.lng,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GeoEntity && lat == other.lat && lng == other.lng;

  @override
  int get hashCode => Object.hash(lat, lng);
}
