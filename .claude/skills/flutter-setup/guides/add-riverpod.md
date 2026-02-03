# Add Riverpod to Flutter Project

Setup Riverpod with code generation for type-safe state management.

## Dependencies

Add to `pubspec.yaml`:

```yaml
dependencies:
  flutter_riverpod: ^2.6.1
  riverpod_annotation: ^2.6.1

dev_dependencies:
  build_runner: ^2.4.13
  riverpod_generator: ^2.6.3
  riverpod_lint: ^2.6.3
```

## Setup

### 1. Wrap App with ProviderScope

```dart
// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
```

### 2. Create a Provider

```dart
// lib/src/features/counter/application/counter_provider.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'counter_provider.g.dart';

@riverpod
class Counter extends _$Counter {
  @override
  int build() => 0;

  void increment() => state++;
  void decrement() => state--;
}
```

### 3. Use in Widgets

```dart
// lib/src/features/counter/presentation/counter_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterScreen extends ConsumerWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);

    return Scaffold(
      body: Center(child: Text('Count: $count')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(counterProvider.notifier).increment(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

### 4. Run Code Generation

```bash
# One-time build
dart run build_runner build -d

# Watch mode (recommended during development)
dart run build_runner watch -d
```

## Analysis Options

Add to `analysis_options.yaml`:

```yaml
analyzer:
  plugins:
    - custom_lint

custom_lint:
  rules:
    - riverpod_final_provider
    - riverpod_avoid_public_notifier_properties
```

## Key Concepts

- **ConsumerWidget**: Use instead of StatelessWidget to access providers
- **ConsumerStatefulWidget**: Use instead of StatefulWidget
- **ref.watch()**: Rebuild when provider changes
- **ref.read()**: Read once without listening (use in callbacks)
- **ref.listen()**: React to changes without rebuilding

## Why Riverpod

- Compile-time safety with code generation
- No BuildContext needed to access state
- Easy testing with provider overrides
- Automatic disposal of resources
- Better performance with fine-grained rebuilds
