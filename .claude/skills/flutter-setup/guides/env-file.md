# Helper Env Class for Environment Variables

Create a type-safe Env class to access environment variables defined with `--dart-define`.

## Implementation

```dart
// lib/src/constants/env.dart
abstract class Env {
  /// API base URL
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://api.example.com',
  );

  /// API key (sensitive - no default)
  static const String apiKey = String.fromEnvironment('API_KEY');

  /// Feature flag
  static const bool enableAnalytics = bool.fromEnvironment(
    'ENABLE_ANALYTICS',
    defaultValue: true,
  );

  /// App version override (useful for testing)
  static const String? appVersionOverride = String.fromEnvironment(
    'APP_VERSION_OVERRIDE',
  ) == '' ? null : String.fromEnvironment('APP_VERSION_OVERRIDE');

  /// Check if running in debug mode
  static const bool isDebug = bool.fromEnvironment('DEBUG', defaultValue: false);
}
```

## Running with Environment Variables

```bash
# Single variable
flutter run --dart-define=API_BASE_URL=https://staging.api.com

# Multiple variables
flutter run \
  --dart-define=API_BASE_URL=https://staging.api.com \
  --dart-define=API_KEY=your-api-key \
  --dart-define=ENABLE_ANALYTICS=false

# Using a .env file with a script
flutter run --dart-define-from-file=.env
```

## Using .env Files (Flutter 3.7+)

Create environment-specific files:

```bash
# .env.dev
API_BASE_URL=https://dev.api.example.com
API_KEY=dev-api-key
ENABLE_ANALYTICS=false

# .env.prod
API_BASE_URL=https://api.example.com
API_KEY=prod-api-key
ENABLE_ANALYTICS=true
```

Run with:
```bash
flutter run --dart-define-from-file=.env.dev
flutter build apk --dart-define-from-file=.env.prod
```

## Usage

```dart
import '/src/constants/env.dart';

class ApiClient {
  final String baseUrl = Env.apiBaseUrl;

  Future<void> makeRequest() async {
    if (Env.apiKey.isEmpty) {
      throw Exception('API_KEY not configured');
    }
    // Use Env.apiKey...
  }
}
```

## Why

- Type-safe access to environment variables
- Compile-time constants (no runtime overhead)
- Default values for optional configuration
- No secrets in source code
- Easy to switch between environments
- Works with CI/CD pipelines
