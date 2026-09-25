import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/cart_provider.dart';

class CartItem extends StatelessWidget {
  final Product product;

  const CartItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    final quantity = cart.quantityOf(product);

    return Card(
      margin: const EdgeInsets.only(bottom: 10),

      child: Padding(
        padding: const EdgeInsets.all(14),

        child: Row(
          children: [

            Text(
              product.icon,
              style: const TextStyle(
                fontSize: 32,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    '৳${product.price.toStringAsFixed(0)} each',
                  ),

                  const SizedBox(height: 8),

                  // Quantity Controls
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          context
                              .read<CartProvider>()
                              .decreaseQuantity(product);
                        },
                        icon: const Icon(
                          Icons.remove_circle_outline,
                        ),
                        visualDensity:
                        VisualDensity.compact,
                      ),

                      Text(
                        '$quantity',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          context
                              .read<CartProvider>()
                              .increaseQuantity(product);
                        },
                        icon: const Icon(
                          Icons.add_circle_outline,
                        ),
                        visualDensity:
                        VisualDensity.compact,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            IconButton(
              tooltip: 'Remove',
              onPressed: () {
                context
                    .read<CartProvider>()
                    .removeFromCart(product);
              },
              icon: const Icon(
                Icons.delete_outline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}