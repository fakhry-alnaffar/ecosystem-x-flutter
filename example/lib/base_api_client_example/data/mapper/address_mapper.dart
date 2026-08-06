import 'package:example/base_api_client_example/data/mapper/geo_mapper.dart';
import 'package:example/base_api_client_example/data/model/address_model.dart';
import 'package:example/base_api_client_example/data/model/geo_model.dart';
import 'package:example/base_api_client_example/domain/entity/address_entity.dart';

extension AddressModelMapper on AddressModel {
  AddressEntity toEntity() => AddressEntity(
        street: street ?? '',
        suite: suite ?? '',
        city: city ?? '',
        zipcode: zipcode ?? '',
        geo: (geo ?? GeoModel.empty()).toEntity(),
      );
}
