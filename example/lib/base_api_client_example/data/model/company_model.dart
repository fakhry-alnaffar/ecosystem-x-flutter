import 'package:flutter/foundation.dart';

@immutable
class CompanyModel {
  final String? name;
  final String? catchPhrase;
  final String? bs;

  const CompanyModel({
    this.name,
    this.catchPhrase,
    this.bs,
  });

  factory CompanyModel.empty() => const CompanyModel(
        name: '',
        catchPhrase: '',
        bs: '',
      );

  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
        name: json['name'] as String?,
        catchPhrase: json['catchPhrase'] as String?,
        bs: json['bs'] as String?,
      );
}
