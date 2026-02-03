# Public Constructor Arguments

Prefer public fields initialized via constructor with `required this.field`. Avoid private backing fields when not necessary.

## Do

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

## Don't

```dart
class UserProfile {
  UserProfile({
    required String id,
    required String name,
    required String email,
    String? avatarUrl,
  })  : _id = id,
        _name = name,
        _email = email,
        _avatarUrl = avatarUrl;

  final String _id;
  final String _name;
  final String _email;
  final String? _avatarUrl;

  String get id => _id;
  String get name => _name;
  String get email => _email;
  String? get avatarUrl => _avatarUrl;
}
```

## Why

- Less boilerplate code
- Cleaner and more readable
- Easier to maintain
- Private backing fields only needed when you have computed getters or need to hide implementation details
