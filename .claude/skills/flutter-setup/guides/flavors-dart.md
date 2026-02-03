# Helper Flavor Enum and getFlavor Function

Define app flavors (environments) using an enum for type-safe flavor detection.

## Implementation

```dart
// lib/src/constants/flavors.dart
enum Flavor {
  dev,
  staging,
  prod,
}

/// Returns the current flavor based on --dart-define=FLAVOR=xxx
Flavor getFlavor() {
  const flavorString = String.fromEnvironment('FLAVOR', defaultValue: 'dev');
  return Flavor.values.firstWhere(
    (f) => f.name == flavorString,
    orElse: () => Flavor.dev,
  );
}

/// Extension for flavor-specific configuration
extension FlavorConfig on Flavor {
  String get apiBaseUrl {
    switch (this) {
      case Flavor.dev:
        return 'https://dev.api.example.com';
      case Flavor.staging:
        return 'https://staging.api.example.com';
      case Flavor.prod:
        return 'https://api.example.com';
    }
  }

  String get appName {
    switch (this) {
      case Flavor.dev:
        return 'MyApp Dev';
      case Flavor.staging:
        return 'MyApp Staging';
      case Flavor.prod:
        return 'MyApp';
    }
  }

  bool get enableLogging {
    switch (this) {
      case Flavor.dev:
      case Flavor.staging:
        return true;
      case Flavor.prod:
        return false;
    }
  }
}
```

## Usage

```dart
// lib/main.dart
import '/src/constants/flavors.dart';

void main() {
  final flavor = getFlavor();

  print('Running ${flavor.appName}');
  print('API: ${flavor.apiBaseUrl}');

  if (flavor.enableLogging) {
    // Setup logging
  }

  runApp(MyApp(flavor: flavor));
}

// Conditional logic based on flavor
class ApiClient {
  final Flavor flavor;

  ApiClient({required this.flavor});

  String get baseUrl => flavor.apiBaseUrl;

  void logRequest(String endpoint) {
    if (flavor.enableLogging) {
      print('Request: $endpoint');
    }
  }
}
```

## Running Different Flavors

```bash
# Development
flutter run --dart-define=FLAVOR=dev

# Staging
flutter run --dart-define=FLAVOR=staging

# Production
flutter build apk --dart-define=FLAVOR=prod
```

## VS Code Launch Configuration

```json
// .vscode/launch.json
{
  "configurations": [
    {
      "name": "Dev",
      "request": "launch",
      "type": "dart",
      "args": ["--dart-define=FLAVOR=dev"]
    },
    {
      "name": "Staging",
      "request": "launch",
      "type": "dart",
      "args": ["--dart-define=FLAVOR=staging"]
    },
    {
      "name": "Prod",
      "request": "launch",
      "type": "dart",
      "args": ["--dart-define=FLAVOR=prod"]
    }
  ]
}
```

## Why

- Type-safe flavor handling with enum
- Centralized configuration per environment
- No magic strings scattered in code
- Easy to add new flavors or configuration options
- Compile-time constant access
