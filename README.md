# ecosystem_x_flutter

The X Flutter ecosystem in one package. Domain contracts, a Dio-based
networking and storage layer, and a production-ready BLoC framework — behind a
single import.

```dart
import 'package:ecosystem_x_flutter/ecosystem_x_flutter.dart';
```

This package replaces the three that used to be consumed separately:

| Was                     | Now                                       |
|-------------------------|-------------------------------------------|
| `x_flutter_core_models` | the **models** layer of this package      |
| `x_flutter_core`        | the **core** layer of this package        |
| `x_flutter_bloc`        | the **bloc** layer of this package        |

Three git dependencies became one. The public API did not change: every type,
mixin and typedef those packages exported is exported here under the same name,
with the same `show` clauses. Migrating is an import change and nothing else.

## Install

```yaml
dependencies:
  ecosystem_x_flutter:
    git:
      url: https://github.com/fakhry-alnaffar/ecosystem-x-flutter.git
      ref: main
```

## The three layers

```
bloc    →  BaseBloc, BaseCubit, mixins, screens          (state management)
  ↓
core    →  ApiClient, storage, DataResponse, Result       (infrastructure)
  ↓
models  →  Failure, ProgressState, Mapper                 (pure contracts)
```

Dependencies run strictly downwards. Nothing points back up, which is what keeps
the models layer free of Flutter concerns and the core layer free of state
management. Inside `lib/src/` each layer keeps its own directory
(`core_models/`, `core/`, `bloc/`) so the boundary is visible in the file tree,
not just in convention.

## Imports

One import gives you everything:

```dart
import 'package:ecosystem_x_flutter/ecosystem_x_flutter.dart';
```

The layer entry points are also public, so a file that needs only domain
contracts can say exactly that:

```dart
import 'package:ecosystem_x_flutter/x_flutter_core_models.dart'; // models only
import 'package:ecosystem_x_flutter/x_flutter_core.dart';        // + networking, storage
import 'package:ecosystem_x_flutter/x_flutter_bloc.dart';        // + state management
```

Each of those exposes exactly what the same-named library in the old package
did, so they double as drop-in replacements during a staged migration. They are
worth reaching for in one concrete case: when a file declares its own type that
would otherwise collide with an unrelated layer's export (the example app hits
this with its own `Result` class — see
`example/lib/base_api_client_example/domain/result.dart`).

## What's inside

**State management** — `BaseBloc`, `BaseCubit`, `BaseBlocState`,
`BaseCubitState`, `BaseStatelessScreen`, `OperationOrchestrator`,
`SingleResultMixin`, `ProgressStreamMixin`, `FailureStreamMixin`,
`BaseUiStateMixin`, `StreamListener`, `AppBlocObserver`.

**Networking** — `ApiClient`, `DioClientModule`, `ApiClientParams`,
`RequestProcessor`, `ErrorProcessor`, `InternalDioRequestProcessor`,
`InternalDioErrorProcessor`, `ServerErrorMapper`, `RetryPolicy`, `HttpStatus`,
`ConnectionChecker`, `DataResponse`, `Result`.

**Storage** — `KeyValueStorage`, `KeyValueReloadableStorage`,
`SharedPreferencesStorage`, `SecuredPreferencesStorage`.

**Domain contracts** — `Failure`, `ApiFailure` and its subtypes,
`CanceledRequestFailure`, `ServerFailure`, `BaseProgressState`,
`DefaultProgressState`, `Mapper`, `MapperIterable`, `OperationStatus`.

## Quick start

```dart
import 'package:ecosystem_x_flutter/ecosystem_x_flutter.dart';

class MyDioModule extends DioClientModule {}

final module = MyDioModule();

final client = module.makeApiClient(
  ApiClientParams(
    baseUrl: 'https://api.example.com/',
    defaultConnectTimeout: 5000,
    defaultReceiveTimeout: 5000,
  ),
);

final processor = module.createInternalDioRequestProcessor();
```

## Repository layout

```
lib/
  ecosystem_x_flutter.dart      the single entry point
  x_flutter_core_models.dart    models layer entry point
  x_flutter_core.dart           core layer entry point
  x_flutter_bloc.dart           bloc layer entry point
  src/
    core_models/                pure domain contracts
    core/                       networking, storage
    bloc/                       state management, screens
test/
  api_surface_test.dart         guards the public API against silent shrinkage
  core_models/ core/ bloc/      the three pre-merge suites, unchanged
example/                        one app demonstrating all three layers
doc/RESPONSE_CONTRACT.md        the DataResponse ↔ Failure contract
MIGRATION.md                    moving an app off the three old packages
```

## Development

```bash
flutter pub get
flutter test
flutter analyze
```

Run the example app:

```bash
cd example && flutter run
```

### The API surface test

`test/api_surface_test.dart` references every symbol the three pre-merge
barrels exported, through the single merged import. The list was extracted from
those packages' own barrels, so it is an independent expectation rather than a
restatement of this package's exports. If a refactor ever drops an export, that
test stops compiling — before a consuming app finds out the hard way. Treat a
failure there as a breaking change, not as a test to update.

## Versioning

`2.0.0` continues the version the three packages had all reached, since the API
is theirs. A change that removes or renames anything in the four entry points is
a major bump.

## License

Apache 2.0 — see [LICENSE](LICENSE).
