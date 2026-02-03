---
name: flutter-setup
description: Setup guides for common Flutter features and infrastructure. Use when adding Riverpod, localization, Sentry, environment variables, flavors, force updates, or adaptive dialogs to a Flutter project.
allowed-tools: Read, Write, Edit, Bash
---

# Flutter Setup Guides

Implementation guides for common Flutter features. Use `$ARGUMENTS` to specify what to set up.

## Available Setups

| Feature | Description |
|---------|-------------|
| `riverpod` | State management with code generation |
| `l10n` | Localization with gen_l10n |
| `sentry` | Error tracking and performance monitoring |
| `env` | Type-safe environment variables |
| `flavors` | Build flavors (dev/staging/prod) |
| `force-update` | Force app updates for critical versions |
| `adaptive-dialog` | Platform-aware alert dialogs |

---

## Riverpod Setup

State management with code generation for type-safe providers.

### Dependencies

```yaml
dependencies:
  flutter_riverpod: ^2.6.1
  riverpod_annotation: ^2.6.1

dev_dependencies:
  build_runner: ^2.4.13
  riverpod_generator: ^2.6.3
  riverpod_lint: ^2.6.3
```

### Implementation

1. **Wrap App with ProviderScope**
```dart
void main() {
  runApp(const ProviderScope(child: MyApp()));
}
```

2. **Create a Provider**
```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'counter_provider.g.dart';

@riverpod
class Counter extends _$Counter {
  @override
  int build() => 0;

  void increment() => state++;
}
```

3. **Use in Widgets**
```dart
class CounterScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);
    return Text('Count: $count');
  }
}
```

4. **Run Code Generation**
```bash
dart run build_runner build -d  # or alias: brb
dart run build_runner watch -d  # or alias: brw
```

---

## Localization (l10n) Setup

Flutter's native internationalization with gen_l10n.

### Dependencies

```yaml
dependencies:
  flutter_localizations:
    sdk: flutter
  intl: any

flutter:
  generate: true
```

### Configuration

Create `l10n.yaml`:
```yaml
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
```

Create `lib/l10n/app_en.arb`:
```json
{
  "@@locale": "en",
  "appTitle": "My App",
  "welcomeMessage": "Welcome back, {userName}!",
  "@welcomeMessage": {
    "placeholders": { "userName": { "type": "String" } }
  }
}
```

### Usage

```dart
// Add extension for clean access
extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

// Use in widgets
Text(context.l10n.welcomeMessage('Alice'))
```

---

## Sentry Setup

Error tracking and performance monitoring.

### Dependencies

```yaml
dependencies:
  sentry_flutter: ^8.0.0
```

### Implementation

```dart
Future<void> main() async {
  await SentryFlutter.init(
    (options) {
      options.dsn = Env.sentryDsn;
      options.environment = Env.environment;
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(const MyApp()),
  );
}
```

### Manual Capture

```dart
try {
  await riskyOperation();
} catch (exception, stackTrace) {
  await Sentry.captureException(exception, stackTrace: stackTrace);
}
```

---

## Environment Variables Setup

Type-safe access to `--dart-define` variables.

### Implementation

```dart
// lib/src/constants/env.dart
abstract class Env {
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://api.example.com',
  );

  static const String apiKey = String.fromEnvironment('API_KEY');

  static const bool enableAnalytics = bool.fromEnvironment(
    'ENABLE_ANALYTICS',
    defaultValue: true,
  );
}
```

### Usage

```bash
# Single variable
flutter run --dart-define=API_BASE_URL=https://staging.api.com

# From file (Flutter 3.7+)
flutter run --dart-define-from-file=.env.dev
```

---

## Build Flavors Setup

Helper enum for build flavors.

### Implementation

```dart
// lib/src/constants/flavor.dart
enum Flavor { dev, staging, prod }

Flavor getFlavor() {
  const flavor = String.fromEnvironment('FLAVOR', defaultValue: 'dev');
  return Flavor.values.firstWhere(
    (f) => f.name == flavor,
    orElse: () => Flavor.dev,
  );
}
```

### Usage

```bash
flutter run --dart-define=FLAVOR=staging
```

---

## Force Update Setup

Force users to update when critical app versions are released.

### Implementation

1. Store minimum version in remote config (Firebase, Supabase, etc.)
2. Check on app launch
3. Show blocking dialog if update required

```dart
class ForceUpdateChecker {
  Future<bool> isUpdateRequired() async {
    final currentVersion = await PackageInfo.fromPlatform();
    final minVersion = await remoteConfig.getMinVersion();
    return Version.parse(currentVersion.version) < Version.parse(minVersion);
  }

  void showUpdateDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const ForceUpdateDialog(),
    );
  }
}
```

---

## Adaptive Alert Dialog

Platform-aware dialogs (Material on Android, Cupertino on iOS).

### Implementation

```dart
Future<bool?> showAdaptiveAlertDialog({
  required BuildContext context,
  required String title,
  required String content,
  String? cancelText,
  String? confirmText,
}) async {
  final isIOS = Theme.of(context).platform == TargetPlatform.iOS;

  if (isIOS) {
    return showCupertinoDialog<bool>(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context, false),
            child: Text(cancelText ?? 'Cancel'),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.pop(context, true),
            child: Text(confirmText ?? 'OK'),
          ),
        ],
      ),
    );
  }

  return showDialog<bool>(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(cancelText ?? 'Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(confirmText ?? 'OK'),
        ),
      ],
    ),
  );
}
```

---

## Shell Aliases

Available for Flutter development:

```bash
fclean    # flutter clean
fpg       # flutter pub get
fpu       # flutter pub upgrade
brb       # dart run build_runner build -d
brw       # dart run build_runner watch -d
fpgbrb    # fpg && brb
fpgbrw    # fpg && brw
```
