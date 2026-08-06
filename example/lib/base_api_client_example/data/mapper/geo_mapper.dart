import 'package:example/base_api_client_example/data/model/geo_model.dart';
import 'package:example/base_api_client_example/domain/entity/geo_entity.dart';

extension GeoModelMapper on GeoModel {
  GeoEntity toEntity() => GeoEntity(
        lat: double.tryParse(lat ?? '') ?? 0.0,
        lng: double.tryParse(lng ?? '') ?? 0.0,
      );
}
