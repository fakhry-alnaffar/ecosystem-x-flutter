import 'package:example/base_api_client_example/data/model/user_model.dart';
import 'package:ecosystem_x_flutter/ecosystem_x_flutter.dart';

abstract interface class UserSource {
  Future<DataResponse<UserModelList>> getUsers();
}
