# Changelog

## 2.0.0

First release of the merged package. `x_flutter_core_models`, `x_flutter_core`
and `x_flutter_bloc` — all three at 2.0.0 — become one dependency,
`ecosystem_x_flutter`, with the same public API.

### Added

- `package:ecosystem_x_flutter/ecosystem_x_flutter.dart` — a single entry point
  exposing all three layers.
- Layer entry points kept public for granular and staged-migration use:
  `x_flutter_core_models.dart`, `x_flutter_core.dart`, `x_flutter_bloc.dart`.
  Each exposes exactly what the same-named library in the old package did.
- `test/api_surface_test.dart` — references every symbol the three pre-merge
  barrels exported, through the single import, so a dropped export breaks the
  build instead of a consuming app.
- One example app covering all three layers, merged from the two that shipped
  with the separate packages (`base_api_client`, `base_bloc`, `base_cubit`,
  `my_account`).

### Changed

- **Consumers must update their imports.** The three old barrel URIs collapse
  into one; see [MIGRATION.md](MIGRATION.md).
- Dependency constraints raised to the newest versions that resolve against the
  Flutter SDK: `connectivity_plus ^7.3.1`, `dio ^5.11.0`,
  `dio_cache_interceptor ^4.0.7`, `equatable ^2.1.0`,
  `internet_connection_checker_plus ^3.1.1`.
- `flutter_secure_storage` widened to `>=10.3.1 <12.0.0`. It deliberately spans
  two majors rather than pinning v11: v11 pulls `win32 ^6.0.1`, which still
  conflicts with `package_info_plus ^9.x` and `device_info_plus ^12.x`. Pinning
  would force that conflict onto every consuming app.
- The models layer now depends on Flutter transitively, because it ships inside
  a Flutter package. It is still free of Flutter *imports*, but it can no longer
  be consumed from a pure-Dart target on its own.
- `test` is no longer a dependency; the merged package uses `flutter_test`,
  which the bloc layer's widget tests require and which provides the same
  `test`/`group`/`expect` API the core tests used.

### Unchanged

- Every exported type, mixin, enum, typedef and `show` clause.
- Every file under `lib/src/`, byte-for-byte apart from its own import URIs.
- All 122 tests from the three packages (40 + 49 + 33), still passing.

---

The history before this release lives in the three source repositories:
[x-flutter-core-models](https://github.com/fakhry-alnaffar/x-flutter-core-models),
[x-flutter-core](https://github.com/fakhry-alnaffar/x-flutter-core),
[x-flutter-bloc](https://github.com/fakhry-alnaffar/x-flutter-bloc).
