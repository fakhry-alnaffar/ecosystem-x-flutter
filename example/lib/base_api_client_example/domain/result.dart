import 'package:ecosystem_x_flutter/x_flutter_core_models.dart';

sealed class Result<T> {
  const Result();

  factory Result.ok(T data) = OkResult<T>;

  factory Result.error({required Failure failure}) = ErrorResult<T>;

  bool get isOk;

  T? get data;

  Failure? get failure;
}

final class OkResult<T> extends Result<T> {
  @override
  final T data;

  @override
  bool get isOk => true;

  @override
  Failure? get failure => null;

  const OkResult(this.data);
}

final class ErrorResult<T> extends Result<T> {
  @override
  final Failure failure;

  @override
  bool get isOk => false;

  @override
  T? get data => null;

  const ErrorResult({required this.failure});
}
