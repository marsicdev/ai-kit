# Constant Sizes

Define and reuse sizes in `lib/src/constants/app_sizes.dart`. Use named constants instead of hardcoded numbers.

## Example Implementation

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

## Usage

```dart
// Do
Padding(padding: EdgeInsets.all(Sizes.p16))
Column(children: [Text('Hello'), gapH24, Text('World')])

// Don't
Padding(padding: EdgeInsets.all(16.0))
Column(children: [Text('Hello'), SizedBox(height: 24), Text('World')])
```

## Why

- Consistent spacing throughout the app
- Easy to adjust spacing globally
- Self-documenting code with meaningful names
- Reduces magic numbers
