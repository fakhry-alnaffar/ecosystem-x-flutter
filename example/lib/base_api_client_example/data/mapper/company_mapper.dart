import 'package:example/base_api_client_example/data/model/company_model.dart';
import 'package:example/base_api_client_example/domain/entity/company_entity.dart';

extension CompanyModelMapper on CompanyModel {
  CompanyEntity toEntity() => CompanyEntity(
        name: name ?? '',
        catchPhrase: catchPhrase ?? '',
        bs: bs ?? '',
      );
}
