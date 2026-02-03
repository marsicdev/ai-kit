# Adaptive Alert Dialog

Use Flutter's built-in `showAdaptiveDialog` and `AlertDialog.adaptive` for platform-aware dialogs (Material on Android, Cupertino on iOS).

## Implementation

```dart
// lib/src/common_widgets/alert_dialogs.dart
import 'package:flutter/material.dart';

/// Shows a platform-adaptive alert dialog
Future<bool?> showAlertDialog({
  required BuildContext context,
  required String title,
  String? content,
  String cancelActionText = 'Cancel',
  String defaultActionText = 'OK',
}) async {
  return showAdaptiveDialog<bool>(
    context: context,
    builder: (context) => AlertDialog.adaptive(
      title: Text(title),
      content: content != null ? Text(content) : null,
      actions: [
        // Actions are also adaptive (TextButton on Android, CupertinoDialogAction on iOS)
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(cancelActionText),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(defaultActionText),
        ),
      ],
    ),
  );
}

/// Shows an exception alert dialog
Future<void> showExceptionAlertDialog({
  required BuildContext context,
  required String title,
  required dynamic exception,
}) =>
    showAlertDialog(
      context: context,
      title: title,
      content: exception.toString(),
      defaultActionText: 'OK',
    );

/// Shows a "not implemented" alert
Future<void> showNotImplementedAlertDialog({required BuildContext context}) =>
    showAlertDialog(
      context: context,
      title: 'Not implemented',
      defaultActionText: 'OK',
    );
```

## Usage

```dart
// Confirmation dialog
final confirmed = await showAlertDialog(
  context: context,
  title: 'Delete item?',
  content: 'This action cannot be undone.',
  cancelActionText: 'Cancel',
  defaultActionText: 'Delete',
);

if (confirmed == true) {
  // Perform delete
}

// Error dialog
try {
  await someAsyncOperation();
} catch (e) {
  showExceptionAlertDialog(
    context: context,
    title: 'Error',
    exception: e,
  );
}
```

## Why

- **Native Look & Feel:** Automatically renders Material dialogs on Android and Cupertino dialogs on iOS.
- **Simplified API:** Uses standard Flutter widgets (`AlertDialog.adaptive`, `showAdaptiveDialog`) instead of manual platform checks.
- **Consistent:** Ensures all dialogs in the app follow the platform's conventions.