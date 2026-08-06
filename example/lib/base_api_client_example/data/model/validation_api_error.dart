import 'package:flutter/foundation.dart';

@immutable
class ValidatorApiError {
  final String? message;
  final List<String>? validatorMessages;

  const ValidatorApiError({
    required this.message,
    required this.validatorMessages,
  });

  factory ValidatorApiError.fromJson(Map<String, dynamic> json) =>
      ValidatorApiError(
        message: json['message'] as String?,
        validatorMessages: (json['validatorMessages'] as List<dynamic>?)
            ?.map((e) => e as String? ?? '')
            .toList(),
      );
}
