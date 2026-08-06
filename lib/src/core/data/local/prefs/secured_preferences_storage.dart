import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ecosystem_x_flutter/x_flutter_core.dart';

/// [KeyValueStorage] backed by [FlutterSecureStorage].
///
/// Values are encrypted on disk using the platform keychain / keystore.
/// Supports [String], [int], [double], and [bool] values; all types are
/// serialised to their string representation before writing.
class SecuredPreferencesStorage
    extends KeyValueStorage<FlutterSecureStorage> {

  @override
  Future<FlutterSecureStorage> create() async => const FlutterSecureStorage(
    aOptions: AndroidOptions(),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  @override
  Future<K> get<K>(String key, K defaultValue) async {
    final s = await storage();
    final value = await s.read(key: key);
    if (value == null) return defaultValue;

    try {
      final dynamic result = switch (defaultValue) {
        String _ => value,
        int _ => int.tryParse(value) ?? defaultValue,
        double _ => double.tryParse(value) ?? defaultValue,
        bool _ => value.toLowerCase() == 'true',
        _ => null,
      };

      return (result ?? defaultValue) as K;
    } catch (_) {
      return defaultValue;
    }
  }

  @override
  Future<void> put<K>(String key, K value) async {
    final s = await storage();
    if (value is String || value is int || value is double || value is bool) {
      await s.write(key: key, value: value.toString());
    }
  }

  @override
  Future<void> clear() async {
    final s = await storage();
    await s.deleteAll();
  }

  @override
  Future<bool> remove(String key) async {
    final s = await storage();
    final existed = await s.containsKey(key: key);
    await s.delete(key: key);
    return existed;
  }

  @override
  Future<bool> contains(String key) async {
    final s = await storage();
    return s.containsKey(key: key);
  }
}
