# Enhanced Enums

Use enums with members and a const constructor for data and behavior. Add multiple properties, constructors, and methods/getters directly on enums.

## Example

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

  /// Calculate fee for a given amount
  double calculateFee(double amount) => amount * processingFee;

  /// Check if this is a digital wallet
  bool get isDigitalWallet => this == applePay;
}
```

## Usage

```dart
final method = PaymentMethod.creditCard;
print(method.label); // 'Credit Card'
print(method.calculateFee(100.0)); // 2.9
print(method.isDigitalWallet); // false
```

## Why

- Type-safe alternative to string constants
- Encapsulates related data and behavior together
- Exhaustive switch statements catch missing cases
- Better IDE support with autocomplete
- No need for separate mapping functions or extension classes
