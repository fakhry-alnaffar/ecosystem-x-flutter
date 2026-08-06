import 'package:flutter/foundation.dart';

@immutable
class GeoModel {
  final String? lat;
  final String? lng;

  const GeoModel({
    required this.lat,
    required this.lng,
  });

  factory GeoModel.empty() => const GeoModel(lat: '', lng: '');

  factory GeoModel.fromJson(Map<String, dynamic> json) => GeoModel(
        lat: json['lat'] as String?,
        lng: json['lng'] as String?,
      );
}
