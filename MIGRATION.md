# Migrating to `ecosystem_x_flutter`

Moving an app off `x_flutter_core_models` + `x_flutter_core` + `x_flutter_bloc`
and onto the single merged package. The public API is unchanged, so this is an
import rewrite — no call sites, no class names, no function signatures move.

## 1. Swap the dependencies

```diff
 dependencies:
-  x_flutter_bloc:
-    git:
-      url: https://github.com/fakhry-alnaffar/x-flutter-bloc.git
-      ref: main
-  x_flutter_core:
-    git:
-      url: https://github.com/fakhry-alnaffar/x-flutter-core.git
-      ref: main
-  x_flutter_core_models:
-    git:
-      url: https://github.com/fakhry-alnaffar/x-flutter-core-models.git
-      ref: main
+  ecosystem_x_flutter:
+    git:
+      url: https://github.com/fakhry-alnaffar/ecosystem-x-flutter.git
+      ref: main
```

## 2. Rewrite the imports

All three old barrels collapse into one:

```
package:x_flutter_core_models/x_flutter_core_models.dart  ─┐
package:x_flutter_core/x_flutter_core.dart                 ├─→  package:ecosystem_x_flutter/ecosystem_x_flutter.dart
package:x_flutter_bloc/x_flutter_bloc.dart                ─┘
```

On Windows (Git Bash) or macOS/Linux:

```bash
grep -rl "package:x_flutter_" lib test | xargs sed -i \
  -e 's|package:x_flutter_core_models/x_flutter_core_models.dart|package:ecosystem_x_flutter/ecosystem_x_flutter.dart|g' \
  -e 's|package:x_flutter_core/x_flutter_core.dart|package:ecosystem_x_flutter/ecosystem_x_flutter.dart|g' \
  -e 's|package:x_flutter_bloc/x_flutter_bloc.dart|package:ecosystem_x_flutter/ecosystem_x_flutter.dart|g'
```

Then `flutter pub get && flutter analyze && flutter test`.

## 3. Three things that bite

### Duplicate import lines

A file that imported two of the old barrels — say `x_flutter_core` **and**
`x_flutter_bloc` — now has the same line twice. Find them:

```bash
for f in $(grep -rl "package:ecosystem_x_flutter" lib test); do
  c=$(grep -c "^import 'package:ecosystem_x_flutter/ecosystem_x_flutter.dart';" "$f")
  [ "$c" -gt 1 ] && echo "$f"
done
```

### Import ordering

`ecosystem_x_flutter` sorts differently from `x_flutter_*`, so a codebase with
the `directives_ordering` lint enabled will flag every touched file — the old
name sorted near the end of the `package:` block, the new one sorts early.
Re-sort the `package:` imports in the affected files. Watch out for a comment
that documented the import below it: moving an import across that comment
silently re-points the comment at the wrong line.

### A widened import surface can collide

The old barrels were nested — `x_flutter_bloc` re-exported `x_flutter_core`,
which re-exported `x_flutter_core_models`. Rewriting a *narrow*
`x_flutter_core_models` import to the full merged barrel widens what that file
sees, and a name the file declares itself can start clashing. The fix is not a
prefix; it is to keep the import as narrow as it was:

```dart
// This file only ever needed domain contracts.
import 'package:ecosystem_x_flutter/x_flutter_core_models.dart';
```

The layer entry points exist for exactly this. See the example app's
`base_api_client_example`, which declares its own `Result` and so imports the
models layer rather than everything.

## 4. Local development against a working copy

To iterate on the library and the app together without a commit-push-pub-get
round trip, add a git-ignored `pubspec_overrides.yaml` next to the app's
`pubspec.yaml`:

```yaml
dependency_overrides:
  ecosystem_x_flutter:
    path: ../ecosystem_x_flutter
```

Add `pubspec_overrides.yaml` to `.gitignore`. It must never reach CI, or a build
machine will look for a path that does not exist there.

## 5. What did *not* change

- Every exported type, mixin, enum, typedef and `show` clause — identical.
- Every source file under `lib/src/` — byte-for-byte identical to its pre-merge
  original apart from its own import URIs.
- The layer boundaries — bloc → core → models, still one-directional.

## Rollback

The three original repositories are untouched and still resolvable. Reverting
means restoring the three dependency entries and undoing the import rewrite;
nothing in the merged package writes to disk, to storage keys, or to any format
that a downgrade would have to read back.
