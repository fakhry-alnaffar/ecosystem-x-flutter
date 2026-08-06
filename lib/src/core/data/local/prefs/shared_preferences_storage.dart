import 'package:ecosystem_x_flutter/src/core/data/local/base/key_value_reloadable_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// [KeyValueReloadableStorage] backed by [SharedPreferences].
///
/// Supports [String], [bool], [int], [double], and [List<String>] values.
/// Unsupported types are silently ignored on [put].
class SharedPreferencesStorage
    extends KeyValueReloadableStorage<SharedPreferences> {

  @override
  Future<SharedPreferences> create() => SharedPreferences.getInstance();

  @override
  Future<K> get<K>(String key, K defaultValue) async {
    final s = await storage();

    final result = switch (defaultValue) {
      String _ => s.getString(key),
      bool _ => s.getBool(key),
      int _ => s.getInt(key),
      double _ => s.getDouble(key),
      List<String> _ => s.getStringList(key),
      _ => null,
    };

    return (result as K?) ?? defaultValue;
  }

  @override
  Future<void> put<K>(String key, K value) async {
    final prefs = await storage();
    switch (value) {
      case String v:
        await prefs.setString(key, v);
      case bool v:
        await prefs.setBool(key, v);
      case double v:
        await prefs.setDouble(key, v);
      case int v:
        await prefs.setInt(key, v);
      case List<String> v:
        await prefs.setStringList(key, v);
      default:
        // Unsupported types are ignored to prevent runtime crashes
        break;
    }
  }

  @override
  Future<void> clear() async {
    final prefs = await storage();
    await prefs.clear();
  }

  @override
  Future<void> reload() async {
    final prefs = await storage();
    await prefs.reload();
  }

  @override
  Future<bool> remove(String key) async {
    final prefs = await storage();
    return prefs.remove(key);
  }

  @override
  Future<bool> contains(String key) async {
    final prefs = await storage();
    return prefs.containsKey(key);
  }
}
