# ecosystem_x_flutter — example

One app demonstrating all three layers, merged from the two example apps that
shipped with the separate packages.

```bash
flutter run
```

## The demos

| Demo                    | Layer exercised   | Shows                                                                     |
|-------------------------|-------------------|---------------------------------------------------------------------------|
| **Base API Client**     | core              | `ApiClient` + `RequestProcessor` against a live API, custom error parsing  |
| **Base Cubit**          | bloc              | `BaseCubit`, single results, progress overlay                              |
| **Base BLoC**           | bloc              | `BaseBloc` with events, `SingleResultMixin`                                |
| **My Account**          | all three         | clean architecture end to end: DTO → mapper → repository → use case → bloc |

`lib/di.dart` wires all four with `get_it`. The networking registrations came
from the core package's example and the state-management ones from the bloc
package's; they now sit in one file and pull every type they need from a single
import.

## Note on imports

Most files here use the single entry point:

```dart
import 'package:ecosystem_x_flutter/ecosystem_x_flutter.dart';
```

Three files under `base_api_client_example/` deliberately use the narrower
models layer instead:

```dart
import 'package:ecosystem_x_flutter/x_flutter_core_models.dart';
```

They declare their own `Result` type in
`base_api_client_example/domain/result.dart`, which would clash with the core
layer's `Result` if they imported everything. Importing only the layer a file
actually needs is the fix — and the reason the layer entry points stay public.
