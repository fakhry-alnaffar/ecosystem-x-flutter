import 'package:example/base_api_client_example/data/model/default_api_error.dart';
import 'package:example/base_api_client_example/data/model/validation_api_error.dart';

class CustomErrorParser {

  const CustomErrorParser._();
  static Object parse(
    int statusCode,
    dynamic response,
  ) {
    if (response is! Map<String, dynamic>) {
      return DefaultApiError(message: response?.toString(), code: null);
    }
    if (statusCode == 400) {
      return ValidatorApiError.fromJson(response);
    }
    return DefaultApiError.fromJson(response);
  }
}
