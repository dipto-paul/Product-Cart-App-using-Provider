import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/products.dart';
import '../providers/cart_provider.dart';
import '../widgets/product_card.dart';
import 'cart_screen.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product Cart',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,

        actions: [
          Consumer<CartProvider>(
            builder: (
                context,
                cart,
                child,
                ) {
              return Stack(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                          const CartScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.shopping_cart_outlined,
                    ),
                  ),

                  if (cart.totalItems > 0)
                    Positioned(
                      right: 5,
                      top: 5,
                      child: Container(
                        padding:
                        const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 2,
                        ),
                        decoration:
                        BoxDecoration(
                          color: Colors.red,
                          borderRadius:
                          BorderRadius.circular(
                            10,
                          ),
                        ),
                        constraints:
                        const BoxConstraints(
                          minWidth: 18,
                          minHeight: 18,
                        ),
                        child: Text(
                          '${cart.totalItems}',
                          textAlign:
                          TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),

          const SizedBox(width: 6),
        ],
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),

        itemCount: products.length,

        itemBuilder: (context, index) {
          final product = products[index];

          return ProductCard(
            product: product,
          );
        },
      ),
    );
  }
}