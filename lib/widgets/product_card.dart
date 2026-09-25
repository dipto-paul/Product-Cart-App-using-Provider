import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/cart_provider.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  IconData get productIcon {
    switch (product.icon) {
      case IconType.headphone:
        return Icons.headphones;

      case IconType.watch:
        return Icons.watch;

      case IconType.keyboard:
        return Icons.keyboard;

      case IconType.mouse:
        return Icons.mouse;

      case IconType.speaker:
        return Icons.speaker;

      case IconType.powerBank:
        return Icons.battery_charging_full;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    final quantity = cart.quantityOf(product);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 14),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .primaryContainer,
                borderRadius:
                BorderRadius.circular(16),
              ),
              child: Icon(
                productIcon,
                size: 36,
                color: Theme.of(context)
                    .colorScheme
                    .onPrimaryContainer,
              ),
            ),

            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 7),

                  Text(
                    '৳${product.price.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context)
                          .colorScheme
                          .primary,
                    ),
                  ),

                  if (quantity > 0) ...[
                    const SizedBox(height: 5),
                    Text(
                      'In cart: $quantity',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.green.shade700,
                        fontWeight:
                        FontWeight.w500,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(width: 8),

            FilledButton(
              onPressed: () {
                context
                    .read<CartProvider>()
                    .addToCart(product);

                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  SnackBar(
                    content: Text(
                      '${product.name} added to cart',
                    ),
                    duration:
                    const Duration(seconds: 1),
                  ),
                );
              },
              child: const Text(
                'Add',
              ),
            ),
          ],
        ),
      ),
    );
  }
}