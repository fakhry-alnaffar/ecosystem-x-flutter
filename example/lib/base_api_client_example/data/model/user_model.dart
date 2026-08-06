import 'package:example/base_api_client_example/data/model/address_model.dart';
import 'package:example/base_api_client_example/data/model/company_model.dart';
import 'package:flutter/foundation.dart';

@immutable
class UserModelList {
  final List<UserModel> users;

  const UserModelList({this.users = const []});

  factory UserModelList.fromJson(List<dynamic> json) => UserModelList(
        users: json
            .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}

@immutable
class UserModel {
  final int? id;
  final String? name;
  final String? username;
  final String? email;
  final AddressModel? address;
  final String? phone;
  final String? website;
  final CompanyModel? company;

  const UserModel({
    this.id,
    this.name,
    this.username,
    this.email,
    this.address,
    this.phone,
    this.website,
    this.company,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] as int?,
        name: json['name'] as String?,
        username: json['username'] as String?,
        email: json['email'] as String?,
        address: json['address'] == null
            ? null
            : AddressModel.fromJson(json['address'] as Map<String, dynamic>),
        phone: json['phone'] as String?,
        website: json['website'] as String?,
        company: json['company'] == null
            ? null
            : CompanyModel.fromJson(json['company'] as Map<String, dynamic>),
      );
}
