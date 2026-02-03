---
name: flutter-patterns
description: Flutter coding patterns and best practices. Use when writing Flutter code, reviewing code quality, or learning Flutter conventions. Covers imports, sizing, enums, constructors, widgets, and Riverpod patterns.
---

# Flutter Coding Patterns

Follow these patterns when writing or reviewing Flutter code.

## Quick Reference

| Pattern | Rule |
|---------|------|
| Imports | Use absolute imports, not relative `../` paths |
| Sizes | Use `Sizes.p16`, `gapH24` constants, not magic numbers |
| Enums | Add properties and methods directly to enums |
| Constructors | Use `required this.field`, not private backing fields |
| Widgets | Create widget classes, not `_build` helper methods |
| Riverpod | Eagerly initialize critical providers before `runApp` |

---

## 1. Absolute Imports

Use package-qualified imports for clarity and easier refactoring.

**Do:**
```dart
import 'package:my_app/src/features/auth/auth_controller.dart';
import 'package:my_app/src/common/widgets/app_button.dart';
import 'package:my_app/src/constants/app_sizes.dart';
```

**Don't:**
```dart
import '../../../common/widgets/app_button.dart';
```

**Why:** Avoids confusing directory traversal, clearer dependency graph, easier to move files.

---

## 2. Constant Sizes

Define spacing in `lib/src/constants/app_sizes.dart` and reuse throughout the app.

**Implementation:**
```dart
// lib/src/constants/app_sizes.dart
import 'package:flutter/material.dart';

class Sizes {
  static const p4 = 4.0;
  static const p8 = 8.0;
  static const p12 = 12.0;
  static const p16 = 16.0;
  static const p20 = 20.0;
  static const p24 = 24.0;
  static const p32 = 32.0;
  static const p48 = 48.0;
  static const p64 = 64.0;
}

/// Constant gap widths
const gapW4 = SizedBox(width: Sizes.p4);
const gapW8 = SizedBox(width: Sizes.p8);
const gapW12 = SizedBox(width: Sizes.p12);
const gapW16 = SizedBox(width: Sizes.p16);
const gapW24 = SizedBox(width: Sizes.p24);
const gapW32 = SizedBox(width: Sizes.p32);

/// Constant gap heights
const gapH4 = SizedBox(height: Sizes.p4);
const gapH8 = SizedBox(height: Sizes.p8);
const gapH12 = SizedBox(height: Sizes.p12);
const gapH16 = SizedBox(height: Sizes.p16);
const gapH24 = SizedBox(height: Sizes.p24);
const gapH32 = SizedBox(height: Sizes.p32);
```

**Usage:**
```dart
// Do
Padding(padding: EdgeInsets.all(Sizes.p16))
Column(children: [Text('Hello'), gapH24, Text('World')])

// Don't
Padding(padding: EdgeInsets.all(16.0))
Column(children: [Text('Hello'), SizedBox(height: 24), Text('World')])
```

---

## 3. Enhanced Enums

Add properties, constructors, and methods directly to enums.

**Example:**
```dart
enum PaymentMethod {
  creditCard(
    label: 'Credit Card',
    icon: Icons.credit_card,
    processingFee: 0.029,
  ),
  paypal(
    label: 'PayPal',
    icon: Icons.payment,
    processingFee: 0.034,
  ),
  applePay(
    label: 'Apple Pay',
    icon: Icons.apple,
    processingFee: 0.015,
  );

  const PaymentMethod({
    required this.label,
    required this.icon,
    required this.processingFee,
  });

  final String label;
  final IconData icon;
  final double processingFee;

  double calculateFee(double amount) => amount * processingFee;
  bool get isDigitalWallet => this == applePay;
}
```

**Why:** Type-safe, encapsulates related data, exhaustive switch statements, better IDE support.

---

## 4. Public Constructor Arguments

Use `required this.field` instead of private backing fields with getters.

**Do:**
```dart
class UserProfile {
  const UserProfile({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
  });

  final String id;
  final String name;
  final String email;
  final String? avatarUrl;
}
```

**Don't:**
```dart
class UserProfile {
  UserProfile({required String id, ...}) : _id = id, ...;

  final String _id;
  String get id => _id;
  // ... unnecessary boilerplate
}
```

**Why:** Less boilerplate, cleaner code. Use private fields only for computed getters.

---

## 5. Widget Classes, Not Build Helpers

Extract UI into StatelessWidget classes instead of `_build` helper methods.

**Do:**
```dart
class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ProductImage(imageUrl: product.imageUrl),
          ProductDetails(product: product),
          ProductActions(product: product),
        ],
      ),
    );
  }
}

class ProductImage extends StatelessWidget {
  const ProductImage({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Image.network(imageUrl, fit: BoxFit.cover);
  }
}
```

**Don't:**
```dart
class ProductCard extends StatelessWidget {
  // ...
  Widget _buildImage() { ... }
  Widget _buildDetails() { ... }
  Widget _buildActions() { ... }
}
```

**Why:** Widget classes are reusable, better performance (Flutter optimizes rebuilds), easier to test, clearer separation of concerns.

---

## 6. Eager Provider Initialization (Riverpod)

For critical dependencies like SharedPreferences, initialize before `runApp`.

**Step 1: Define Provider**
```dart
@Riverpod(keepAlive: true)
Future<SharedPreferences> sharedPreferences(SharedPreferencesRef ref) {
  return SharedPreferences.getInstance();
}
```

**Step 2: Initialize Before runApp**
```dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final container = ProviderContainer();
  await container.read(sharedPreferencesProvider.future);

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MyApp(),
    ),
  );
}
```

**Step 3: Access Synchronously**
```dart
class SettingsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefs = ref.watch(sharedPreferencesProvider).requireValue;
    // Use prefs synchronously
  }
}
```

**Why:** Avoids loading states for critical deps, no null checks throughout app, clean bootstrapping.

---

## Shell Aliases

These aliases are available for Flutter development:

```bash
fclean    # flutter clean
fpg       # flutter pub get
fpu       # flutter pub upgrade
brb       # dart run build_runner build -d
brw       # dart run build_runner watch -d
fpgbrb    # fpg && brb
fpgbrw    # fpg && brw
```

**Note:** Assume `brw` is running in projects that use build_runner.
