# Eager Provider Initialization (Riverpod)

For providers that must be ready before the app starts (like SharedPreferences), use eager initialization with `keepAlive: true`.

## Implementation

### 1. Define the Provider

```dart
// lib/src/features/settings/data/shared_preferences_provider.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preferences_provider.g.dart';

@Riverpod(keepAlive: true)
Future<SharedPreferences> sharedPreferences(SharedPreferencesRef ref) {
  return SharedPreferences.getInstance();
}
```

### 2. Eagerly Initialize Before runApp

```dart
// lib/main.dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final container = ProviderContainer();

  // Eagerly initialize SharedPreferences
  await container.read(sharedPreferencesProvider.future);

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MyApp(),
    ),
  );
}
```

### 3. Access the Value Synchronously

```dart
// Anywhere in the app
class SettingsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Use requireValue since we know it's already initialized
    final prefs = ref.watch(sharedPreferencesProvider).requireValue;

    return Switch(
      value: prefs.getBool('darkMode') ?? false,
      onChanged: (value) => prefs.setBool('darkMode', value),
    );
  }
}
```

## Key Points

- `@Riverpod(keepAlive: true)` prevents the provider from being disposed
- `container.read(provider.future)` ensures initialization completes before app starts
- `.requireValue` safely accesses the value since we know it's already loaded
- Use `UncontrolledProviderScope` to pass the pre-initialized container to the widget tree

## Why

- Avoids loading states for critical dependencies
- Prevents null checks and async handling throughout the app
- Guarantees the value is available synchronously after initialization
- Clean separation between app bootstrapping and UI code
