# Widget Classes, Not Build Helpers

Create reusable widget classes instead of private `_build` helper methods. Extract UI into StatelessWidget classes.

## Do

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

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(product.name),
        Text('\$${product.price}'),
      ],
    );
  }
}
```

## Don't

```dart
class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          _buildImage(),
          _buildDetails(),
          _buildActions(),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return Image.network(product.imageUrl, fit: BoxFit.cover);
  }

  Widget _buildDetails() {
    return Column(
      children: [
        Text(product.name),
        Text('\$${product.price}'),
      ],
    );
  }

  Widget _buildActions() {
    return Row(children: [...]);
  }
}
```

## Why

- Widget classes are reusable across the app
- Better performance: Flutter can optimize rebuild of individual widgets
- Easier to test in isolation
- Clearer separation of concerns
- Build helpers can't have their own state or lifecycle
- Follows Flutter's composition-over-inheritance philosophy
