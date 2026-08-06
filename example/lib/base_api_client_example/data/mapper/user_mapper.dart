import 'package:example/base_api_client_example/data/mapper/address_mapper.dart';
import 'package:example/base_api_client_example/data/mapper/company_mapper.dart';
import 'package:example/base_api_client_example/data/model/address_model.dart';
import 'package:example/base_api_client_example/data/model/company_model.dart';
import 'package:example/base_api_client_example/data/model/user_model.dart';
import 'package:example/base_api_client_example/domain/entity/user_entity.dart';

extension UserModelMapper on UserModel {
  UserEntity toEntity() => UserEntity(
        id: id ?? -1,
        name: name ?? '',
        username: username ?? '',
        email: email ?? '',
        address: (address ?? AddressModel.empty()).toEntity(),
        phone: phone ?? '',
        website: website ?? '',
        company: (company ?? CompanyModel.empty()).toEntity(),
      );
}
