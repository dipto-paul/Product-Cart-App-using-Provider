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

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    final quantity = cart.quantityOf(product);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .surfaceContainerHighest,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                product.icon,
                style: const TextStyle(
                  fontSize: 34,
                ),
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
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    '৳${product.price.toStringAsFixed(0)}',
                    style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  if (quantity > 0)
                    Padding(
                      padding:
                      const EdgeInsets.only(top: 4),
                      child: Text(
                        'In cart: $quantity',
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(width: 8),
            FilledButton(
              onPressed: () {
                context
                    .read<CartProvider>()
                    .addToCart(product);
              },
              child: const Text(
                'Add to Cart',
              ),
            ),
          ],
        ),
      ),
    );
  }
}