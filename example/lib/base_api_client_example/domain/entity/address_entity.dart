import 'package:example/base_api_client_example/domain/entity/geo_entity.dart';
import 'package:flutter/foundation.dart';

@immutable
class AddressEntity {
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final GeoEntity geo;

  const AddressEntity({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.geo,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddressEntity &&
          street == other.street &&
          suite == other.suite &&
          city == other.city &&
          zipcode == other.zipcode &&
          geo == other.geo;

  @override
  int get hashCode => Object.hash(street, suite, city, zipcode, geo);
}
