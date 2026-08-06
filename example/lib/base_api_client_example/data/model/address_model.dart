import 'package:example/base_api_client_example/data/model/geo_model.dart';
import 'package:flutter/foundation.dart';

@immutable
class AddressModel {
  final String? street;
  final String? suite;
  final String? city;
  final String? zipcode;
  final GeoModel? geo;

  const AddressModel({
    this.street,
    this.suite,
    this.city,
    this.zipcode,
    this.geo,
  });

  factory AddressModel.empty() => const AddressModel(
        street: '',
        suite: '',
        city: '',
        zipcode: '',
        geo: GeoModel(lat: '', lng: ''),
      );

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        street: json['street'] as String?,
        suite: json['suite'] as String?,
        city: json['city'] as String?,
        zipcode: json['zipcode'] as String?,
        geo: json['geo'] == null
            ? null
            : GeoModel.fromJson(json['geo'] as Map<String, dynamic>),
      );
}
