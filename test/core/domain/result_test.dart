import 'package:flutter_test/flutter_test.dart';
import 'package:ecosystem_x_flutter/x_flutter_core.dart';

void main() {
  group('Result.ok', () {
    test('isSuccess is true', () {
      final r = Result.ok(42);
      expect(r.isSuccess, isTrue);
    });

    test('isError is false', () {
      final r = Result.ok(42);
      expect(r.isError, isFalse);
    });

    test('data returns the value', () {
      final r = Result.ok('hello');
      expect(r.data, 'hello');
    });

    test('asSuccess returns ResultSuccess', () {
      final r = Result<int>.ok(7);
      expect(r.asSuccess, isA<ResultSuccess<int>>());
      expect(r.asSuccess.data, 7);
    });

    test('asError throws StateError', () {
      final r = Result<int>.ok(1);
      expect(() => r.asError, throwsStateError);
    });
  });

  group('Result.error', () {
    const failure = ConnectionFailure();

    test('isError is true', () {
      final r = Result<int>.error(error: failure);
      expect(r.isError, isTrue);
    });

    test('isSuccess is false', () {
      final r = Result<int>.error(error: failure);
      expect(r.isSuccess, isFalse);
    });

    test('data throws StateError', () {
      final r = Result<int>.error(error: failure);
      expect(() => r.data, throwsStateError);
    });

    test('asError.error returns the failure', () {
      final r = Result<int>.error(error: failure);
      expect(r.asError.error, same(failure));
    });

    test('asSuccess throws StateError on failure result', () {
      final r = Result<int>.error(error: failure);
      expect(() => r.asSuccess, throwsStateError);
    });
  });

  group('Result pattern matching', () {
    test('switch on ResultSuccess', () {
      final Result<int> r = Result.ok(99);
      final label = switch (r) {
        ResultSuccess(:final data) => 'ok:$data',
        ResultFailure() => 'fail',
      };
      expect(label, 'ok:99');
    });

    test('switch on ResultFailure', () {
      final Result<int> r = Result.error(error: const ConnectionFailure());
      final label = switch (r) {
        ResultSuccess() => 'ok',
        ResultFailure(:final error) => 'fail:${error.runtimeType}',
      };
      expect(label, 'fail:ConnectionFailure');
    });
  });

  group('Result works with all Failure subtypes', () {
    test('ApiResponseFailure', () {
      const f = ApiResponseFailure(statusCode: 400, message: 'Bad request');
      final r = Result<String>.error(error: f);
      expect(r.asError.error, isA<ApiResponseFailure>());
    });

    test('ConnectionFailure', () {
      final r = Result<void>.error(error: const ConnectionFailure());
      expect(r.asError.error, isA<ConnectionFailure>());
    });

    test('ApiUnauthorizedFailure', () {
      final r = Result<void>.error(error: const ApiUnauthorizedFailure());
      expect(r.asError.error, isA<ApiUnauthorizedFailure>());
    });
  });
}
