import 'package:flutter/foundation.dart';

/// Base class for key-value storage implementations.
///
/// Lazily initialises the underlying storage on first access — concurrent
/// callers all await the same [Future] so [create] is called exactly once.
///
/// Extend this class and implement [create] plus the CRUD methods to provide
/// a concrete storage backend.
abstract class KeyValueStorage<T> {
  Future<T>? _initFuture;

  /// Returns the underlying storage instance, initialising it on first call.
  @protected
  Future<T> storage() => _initFuture ??= create();

  /// Creates and returns a new instance of the underlying storage backend.
  @protected
  Future<T> create();

  /// Reads the value associated with [key], returning [defaultValue] if absent.
  Future<K> get<K>(String key, K defaultValue);

  /// Writes [value] under [key], overwriting any existing entry.
  Future<void> put<K>(String key, K value);

  /// Removes all entries from the storage.
  Future<void> clear();

  /// Deletes the entry for [key]. Returns `true` if the key existed.
  Future<bool> remove(String key);

  /// Returns `true` if the storage contains an entry for [key].
  Future<bool> contains(String key);
}
