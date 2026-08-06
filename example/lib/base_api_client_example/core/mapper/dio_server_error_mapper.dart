import 'package:example/base_api_client_example/data/model/default_api_error.dart';
import 'package:example/base_api_client_example/data/model/validation_api_error.dart';
import 'package:ecosystem_x_flutter/ecosystem_x_flutter.dart';

class DioServerErrorMapper extends ServerErrorMapper {
  static final DioServerErrorMapper _singleton =
      DioServerErrorMapper._internal();

  factory DioServerErrorMapper() => _singleton;

  DioServerErrorMapper._internal();

  @override
  Failure? onCustomError(Object data, int? statusCode) => switch (data) {
        DefaultApiError(:final message) => ApiResponseFailure(
            statusCode: statusCode ?? 0,
            message: message ?? '',
          ),
        ValidatorApiError(:final validatorMessages) => ApiResponseFailure(
            statusCode: statusCode ?? 0,
            message: validatorMessages?.join('\n') ?? '',
          ),
        _ => const ApiUnknownFailure(),
      };
}
