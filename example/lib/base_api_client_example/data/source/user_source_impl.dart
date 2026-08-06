import 'package:example/base_api_client_example/data/model/user_model.dart';
import 'package:example/base_api_client_example/data/source/user_source.dart';
import 'package:ecosystem_x_flutter/ecosystem_x_flutter.dart';

class UserSourceImpl implements UserSource {
  static const String _users = '/users';

  final ApiClient _apiClient;
  final RequestProcessor _requestProcessor;

  const UserSourceImpl(this._apiClient, this._requestProcessor);

  @override
  Future<DataResponse<UserModelList>> getUsers() {
    return _requestProcessor.processRequest(
      onRequest: () => _apiClient.client.get(_users),
      onParse: (response) {
        return UserModelList.fromJson(response.data);
      },
    );
  }
}
