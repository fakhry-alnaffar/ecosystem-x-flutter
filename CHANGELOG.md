# Changelog

## 2.1.0

### Changed

- `flutter_secure_storage` now accepts `>=10.3.1 <12.0.0` instead of `^10.3.1`.
  The package works on both majors; CI proves v10 in the "Oldest allowed
  dependencies" job and v11 (11.2.0) in the main one. Which major ships is the
  app's decision: v11 drops the Android ciphers deprecated in v10, so a user
  who updates from a pre-v10 build straight to a v11 build loses what was
  stored. Apps that have shipped v10 for a while are already migrated. The
  compileSdk 37 requirement mentioned under 2.0.0 is gone since v11.1.0, which
  builds with Flutter's own compileSdk.
- `SecuredPreferencesStorage` now sets `migrateWithBackup: true` on Android. It
  defaults to false, and without it a migration that fails part-way falls
  through to `resetOnError`, which erases the store.

### Added

- Tests for `SecuredPreferencesStorage`: every supported type round-trips,
  defaults, unparsable values, `remove`, `contains` and `clear`.

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
- `flutter_secure_storage` stays capped at `^10.3.1`, matching the pre-merge
  bound. The code works on v11 too — it was analyzed and tested against both —
  but v11 removes the Android ciphers deprecated in v10 and its changelog states
  that data written with them becomes unusable, so an app that jumps straight to
  v11 can leave users with unreadable stored sessions. v11 also raises minSdk to
  24 and compileSdk to 37. Moving up is an app-level decision that needs the
  migration path verified; a library should not make it silently.
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

### Provenance — reproducing the merge

The history before this release lives in the three source repositories, and the
merge was taken from these exact commits:

| Package                 | Repository                                                              | Commit    |
|-------------------------|-------------------------------------------------------------------------|-----------|
| `x_flutter_core_models` | [x-flutter-core-models](https://github.com/fakhry-alnaffar/x-flutter-core-models) | `363a48d` |
| `x_flutter_core`        | [x-flutter-core](https://github.com/fakhry-alnaffar/x-flutter-core)               | `68ef3fc` |
| `x_flutter_bloc`        | [x-flutter-bloc](https://github.com/fakhry-alnaffar/x-flutter-bloc)               | `7925af9` |

All three repositories are public and untouched, so the "0 differences" claim
above is verifiable by anyone, not just on the machine the merge was done on.
Clone them at those commits and compare, remembering that the layer directory
prefix and each file's own import URIs are the intended difference:

```
x-flutter-core-models/lib/src/**  ->  lib/src/core_models/**
x-flutter-core/lib/src/**         ->  lib/src/core/**
x-flutter-bloc/lib/src/bloc/**    ->  lib/src/bloc/**
x-flutter-bloc/lib/src/ui/**      ->  lib/src/bloc/ui/**
```
