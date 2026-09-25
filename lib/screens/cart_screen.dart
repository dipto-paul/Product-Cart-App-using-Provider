import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../widgets/cart_item.dart';
import 'product_list_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  String formatPrice(double price) {
    return '৳${price.toStringAsFixed(0)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Cart',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Consumer<CartProvider>(
        builder: (
            context,
            cart,
            child,
            ) {
          if (cart.cartProducts.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),

                child: Column(
                  mainAxisAlignment:
                  MainAxisAlignment.center,

                  children: [
                    Icon(
                      Icons
                          .remove_shopping_cart_outlined,
                      size: 90,
                      color: Colors.grey.shade500,
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      'Your Cart is Empty',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Add some products to your cart.',
                      style: TextStyle(
                        color:
                        Colors.grey.shade600,
                      ),
                    ),

                    const SizedBox(height: 25),

                    FilledButton.icon(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                            const ProductListScreen(),
                          ),
                              (route) => false,
                        );
                      },
                      icon: const Icon(
                        Icons.shopping_bag_outlined,
                      ),
                      label: const Text(
                        'Continue Shopping',
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(16),

            children: [
              // Cart Items
              ...cart.cartProducts.map(
                    (product) {
                  return CartItem(
                    product: product,
                  );
                },
              ),

              const SizedBox(height: 8),


              Card(
                child: Padding(
                  padding:
                  const EdgeInsets.all(18),

                  child: Column(
                    children: [
                      const Align(
                        alignment:
                        Alignment.centerLeft,
                        child: Text(
                          'Cart Summary',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      SummaryRow(
                        label: 'Total Items',
                        value:
                        '${cart.totalItems}',
                      ),

                      const SizedBox(height: 12),

                      SummaryRow(
                        label: 'Subtotal',
                        value: formatPrice(
                          cart.subtotal,
                        ),
                      ),

                      const SizedBox(height: 12),

                      SummaryRow(
                        label:
                        'Discount (10%)',
                        value: formatPrice(
                          cart.discount,
                        ),
                      ),

                      const Divider(
                        height: 30,
                      ),

                      SummaryRow(
                        label: 'Final Total',
                        value: formatPrice(
                          cart.finalTotal,
                        ),
                        isTotal: true,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),


              OutlinedButton.icon(
                onPressed: () {
                  context
                      .read<CartProvider>()
                      .clearCart();
                },
                icon: const Icon(
                  Icons.delete_sweep_outlined,
                ),
                label: const Text(
                  'Clear Cart',
                ),
              ),

              const SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }
}

class SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;

  const SummaryRow({
    super.key,
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
      MainAxisAlignment.spaceBetween,

      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 18 : 15,
            fontWeight: isTotal
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),

        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 20 : 15,
            fontWeight: FontWeight.bold,
            color: isTotal
                ? Theme.of(context)
                .colorScheme
                .primary
                : null,
          ),
        ),
      ],
    );
  }
}