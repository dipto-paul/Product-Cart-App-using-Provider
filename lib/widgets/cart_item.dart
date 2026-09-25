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
      margin: const EdgeInsets.only(bottom: 12),

      child: Padding(
        padding: const EdgeInsets.all(14),

        child: Row(
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .primaryContainer,
                borderRadius:
                BorderRadius.circular(14),
              ),
              child: Icon(
                productIcon,
                size: 30,
                color: Theme.of(context)
                    .colorScheme
                    .onPrimaryContainer,
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
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    '৳${product.price.toStringAsFixed(0)} each',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          context
                              .read<CartProvider>()
                              .decreaseQuantity(
                            product,
                          );
                        },
                        icon: const Icon(
                          Icons.remove_circle_outline,
                        ),
                        visualDensity:
                        VisualDensity.compact,
                      ),

                      Container(
                        width: 35,
                        alignment:
                        Alignment.center,
                        child: Text(
                          '$quantity',
                          style:
                          const TextStyle(
                            fontWeight:
                            FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          context
                              .read<CartProvider>()
                              .increaseQuantity(
                            product,
                          );
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
              onPressed: () {
                context
                    .read<CartProvider>()
                    .removeFromCart(product);
              },
              tooltip: 'Remove',
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