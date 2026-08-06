import 'package:flutter/foundation.dart';

@immutable
class DefaultApiError {
  final String? message;
  final String? code;

  const DefaultApiError({
    required this.message,
    required this.code,
  });

  factory DefaultApiError.fromJson(Map<String, dynamic> json) => DefaultApiError(
        message: json['message'] as String?,
        code: json['code'] as String?,
      );
}
