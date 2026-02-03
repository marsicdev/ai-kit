# Force Update Setup

Implement a force update mechanism to ensure users are on a minimum required app version.

## Implementation

### 1. Version Check Provider

```dart
// lib/src/features/force_update/data/app_version_provider.dart
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_version_provider.g.dart';

@Riverpod(keepAlive: true)
Future<PackageInfo> packageInfo(PackageInfoRef ref) {
  return PackageInfo.fromPlatform();
}

@riverpod
Future<bool> needsForceUpdate(NeedsForceUpdateRef ref) async {
  final packageInfo = await ref.watch(packageInfoProvider.future);
  final currentVersion = packageInfo.version;

  // Fetch minimum version from remote config or API
  final minVersion = await ref.watch(minRequiredVersionProvider.future);

  return _isVersionLower(currentVersion, minVersion);
}

bool _isVersionLower(String current, String minimum) {
  final currentParts = current.split('.').map(int.parse).toList();
  final minParts = minimum.split('.').map(int.parse).toList();

  for (var i = 0; i < minParts.length; i++) {
    if (i >= currentParts.length) return true;
    if (currentParts[i] < minParts[i]) return true;
    if (currentParts[i] > minParts[i]) return false;
  }
  return false;
}
```

### 2. Force Update Screen

```dart
// lib/src/features/force_update/presentation/force_update_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ForceUpdateScreen extends StatelessWidget {
  const ForceUpdateScreen({super.key});

  static const appStoreUrl = 'https://apps.apple.com/app/idXXXXXXXXXX';
  static const playStoreUrl = 'https://play.google.com/store/apps/details?id=com.example.app';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.system_update, size: 64),
              const SizedBox(height: 24),
              const Text(
                'Update Required',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'Please update to the latest version to continue using the app.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _openStore,
                child: const Text('Update Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openStore() {
    final url = Platform.isIOS ? appStoreUrl : playStoreUrl;
    launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }
}
```

### 3. App Startup Check

```dart
// lib/main.dart
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final needsUpdate = ref.watch(needsForceUpdateProvider);

    return MaterialApp(
      home: needsUpdate.when(
        data: (needsUpdate) => needsUpdate
            ? const ForceUpdateScreen()
            : const HomeScreen(),
        loading: () => const SplashScreen(),
        error: (_, __) => const HomeScreen(), // Fail open
      ),
    );
  }
}
```

### 4. Remote Config (Firebase Example)

```dart
// lib/src/features/force_update/data/min_version_provider.dart
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'min_version_provider.g.dart';

@riverpod
Future<String> minRequiredVersion(MinRequiredVersionRef ref) async {
  final remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.fetchAndActivate();
  return remoteConfig.getString('min_app_version');
}
```

## Dependencies

```yaml
dependencies:
  package_info_plus: ^8.0.0
  url_launcher: ^6.2.5
  firebase_remote_config: ^5.0.0  # Optional
```

## Why

- Prevents users from using outdated app versions with known issues
- Ensures API compatibility
- Security patches reach all users
- Graceful UX with clear update instructions
