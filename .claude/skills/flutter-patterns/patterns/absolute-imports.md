# Absolute Imports

Prefer absolute imports over package-qualified paths for internal code.

## Do

```dart
import 'package:my_app/src/features/auth/auth_controller.dart';
import 'package:my_app/src/common/widgets/app_button.dart';
import 'package:my_app/src/constants/app_sizes.dart';
```

## Don't

```dart
import '../../../common/widgets/app_button.dart';
```

## Why

- Avoids confusing `../../..` directory traversal
- Clearer dependency graph: easy to see where files come from
- Easier to move files without breaking relative paths
- Standard practice for large projects
