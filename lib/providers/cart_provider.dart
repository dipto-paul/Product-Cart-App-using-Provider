import 'package:flutter/foundation.dart';

import '../data/products.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final Map<int, int> _cartItems = {};

  Map<int, int> get cartItems {
    return Map.unmodifiable(_cartItems);
  }


  int get totalItems {
    return _cartItems.values.fold(
      0,
          (total, quantity) => total + quantity,
    );
  }

  bool isInCart(Product product) {
    return _cartItems.containsKey(product.id);
  }

  int quantityOf(Product product) {
    return _cartItems[product.id] ?? 0;
  }

  void addToCart(Product product) {
    if (_cartItems.containsKey(product.id)) {
      _cartItems[product.id] =
          _cartItems[product.id]! + 1;
    } else {
      _cartItems[product.id] = 1;
    }

    notifyListeners();
  }

  void increaseQuantity(Product product) {
    if (!_cartItems.containsKey(product.id)) {
      return;
    }

    _cartItems[product.id] =
        _cartItems[product.id]! + 1;

    notifyListeners();
  }

  void decreaseQuantity(Product product) {
    if (!_cartItems.containsKey(product.id)) {
      return;
    }

    final currentQuantity =
    _cartItems[product.id]!;

    if (currentQuantity > 1) {
      _cartItems[product.id] =
          currentQuantity - 1;
    } else {
      _cartItems.remove(product.id);
    }

    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cartItems.remove(product.id);

    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();

    notifyListeners();
  }


  List<Product> get cartProducts {
    return products.where((product) {
      return _cartItems.containsKey(product.id);
    }).toList();
  }

  double get subtotal {
    double total = 0;

    for (final entry in _cartItems.entries) {
      final product = products.firstWhere(
            (product) => product.id == entry.key,
      );

      final quantity = entry.value;

      total += product.price * quantity;
    }

    return total;
  }


  double get discount {
    if (subtotal > 2000) {
      return subtotal * 0.10;
    }

    return 0;
  }


  double get finalTotal {
    return subtotal - discount;
  }
}