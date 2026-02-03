# Sentry Initialization

Setup Sentry for error tracking and performance monitoring in Flutter.

## Dependencies

```yaml
dependencies:
  sentry_flutter: ^8.0.0
```

## Implementation

### 1. Initialize Sentry

```dart
// lib/main.dart
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import '/src/constants/env.dart';

Future<void> main() async {
  await SentryFlutter.init(
    (options) {
      options.dsn = Env.sentryDsn;
      options.environment = Env.environment; // 'dev', 'staging', 'prod'
      options.tracesSampleRate = 1.0; // Adjust for production
      options.profilesSampleRate = 1.0; // Adjust for production

      // Don't send events in debug mode
      options.beforeSend = (event, hint) {
        if (Env.isDebug) return null;
        return event;
      };
    },
    appRunner: () => runApp(
      DefaultAssetBundle(
        bundle: SentryAssetBundle(),
        child: const MyApp(),
      ),
    ),
  );
}
```

### 2. Environment Configuration

```dart
// lib/src/constants/env.dart
abstract class Env {
  static const String sentryDsn = String.fromEnvironment('SENTRY_DSN');
  static const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: 'dev',
  );
  static const bool isDebug = bool.fromEnvironment('DEBUG', defaultValue: false);
}
```

### 3. Manual Error Capture

```dart
// Capture exception with context
try {
  await riskyOperation();
} catch (exception, stackTrace) {
  await Sentry.captureException(
    exception,
    stackTrace: stackTrace,
    withScope: (scope) {
      scope.setTag('feature', 'checkout');
      scope.setExtra('cart_items', cartItems.length);
    },
  );
  rethrow; // Or handle gracefully
}
```

### 4. Add User Context

```dart
// When user logs in
void setUserContext(User user) {
  Sentry.configureScope((scope) {
    scope.setUser(SentryUser(
      id: user.id,
      email: user.email,
      username: user.displayName,
    ));
  });
}

// When user logs out
void clearUserContext() {
  Sentry.configureScope((scope) {
    scope.setUser(null);
  });
}
```

### 5. Breadcrumbs for Context

```dart
// Add navigation breadcrumb
Sentry.addBreadcrumb(Breadcrumb(
  category: 'navigation',
  message: 'Navigated to ProductDetails',
  data: {'product_id': productId},
));

// Add user action breadcrumb
Sentry.addBreadcrumb(Breadcrumb(
  category: 'user.action',
  message: 'Added item to cart',
  data: {'item_id': itemId, 'quantity': quantity},
));
```

### 6. Performance Monitoring

```dart
// Manual transaction
final transaction = Sentry.startTransaction(
  'processOrder',
  'task',
  bindToScope: true,
);

try {
  final span = transaction.startChild('validateCart');
  await validateCart();
  span.finish();

  final paymentSpan = transaction.startChild('processPayment');
  await processPayment();
  paymentSpan.finish();

  transaction.finish(status: const SpanStatus.ok());
} catch (e) {
  transaction.finish(status: const SpanStatus.internalError());
  rethrow;
}
```

### 7. Navigation Observer

```dart
// lib/main.dart
MaterialApp(
  navigatorObservers: [
    SentryNavigatorObserver(),
  ],
  // ...
)
```

## Running

```bash
flutter run \
  --dart-define=SENTRY_DSN=https://xxx@xxx.ingest.sentry.io/xxx \
  --dart-define=ENVIRONMENT=dev
```

## Best Practices

- Set appropriate `tracesSampleRate` for production (0.1 - 0.2)
- Use `beforeSend` to filter sensitive data
- Add meaningful breadcrumbs before critical operations
- Set user context for better error debugging
- Use transactions for performance-critical flows

## Why

- Automatic crash reporting with stack traces
- Performance monitoring and bottleneck identification
- User session replay and breadcrumbs
- Release tracking and regression detection
- Integrates with CI/CD for source maps
