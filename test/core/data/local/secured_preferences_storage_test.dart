import 'package:ecosystem_x_flutter/x_flutter_core.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

// Runs against the plugin's in-memory test platform, so it proves the
// wrapper's own contract -- type round-trips, defaults, remove/contains --
// on whichever flutter_secure_storage major the resolver picked (v10 in the
// "oldest allowed" CI job, v11 in the main one). It cannot prove anything
// about the native keystore/keychain; that needs a device.
void main() {
  late SecuredPreferencesStorage storage;

  setUp(() {
    FlutterSecureStorage.setMockInitialValues({'existing': 'kept'});
    storage = SecuredPreferencesStorage();
  });

  test('reads a value that was already stored', () async {
    expect(await storage.get<String>('existing', ''), 'kept');
  });

  test('round-trips every supported type', () async {
    await storage.put<String>('s', 'value');
    await storage.put<int>('i', 42);
    await storage.put<double>('d', 1.5);
    await storage.put<bool>('b', true);

    expect(await storage.get<String>('s', ''), 'value');
    expect(await storage.get<int>('i', 0), 42);
    expect(await storage.get<double>('d', 0), 1.5);
    expect(await storage.get<bool>('b', false), isTrue);
  });

  test('returns the default for a missing key', () async {
    expect(await storage.get<String>('missing', 'fallback'), 'fallback');
    expect(await storage.get<int>('missing', 7), 7);
  });

  test('returns the default when a stored value does not parse', () async {
    await storage.put<String>('n', 'not a number');
    expect(await storage.get<int>('n', 3), 3);
    expect(await storage.get<double>('n', 2.5), 2.5);
  });

  test('ignores unsupported types instead of writing them', () async {
    await storage.put<List<String>>('l', ['a']);
    expect(await storage.contains('l'), isFalse);
  });

  test('remove reports whether the key existed', () async {
    expect(await storage.remove('existing'), isTrue);
    expect(await storage.contains('existing'), isFalse);
    expect(await storage.remove('existing'), isFalse);
  });

  test('clear removes everything', () async {
    await storage.put<String>('s', 'value');
    await storage.clear();
    expect(await storage.contains('s'), isFalse);
    expect(await storage.contains('existing'), isFalse);
  });
}
