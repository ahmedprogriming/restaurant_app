import 'package:flutter/foundation.dart';
import 'package:restaurant/models/cart_item_model.dart';
import 'package:restaurant/models/product_model.dart';

/// Clean, Reactive Cart State Manager following Clean Architecture.
///
/// Uses [ValueNotifier<List<CartItemModel>>] for dependency-free, zero-overhead
/// reactive updates across all widgets, badges, product details, and the cart screen.
class CartState {
  static final ValueNotifier<List<CartItemModel>> itemsNotifier =
      ValueNotifier<List<CartItemModel>>([
    // Pre-populate with 1 sample item (e.g. Strawberry or Salmon) for instant beautiful UX
    CartItemModel(
      product: ProductModel.sampleProducts[1], // Strawberry
      quantity: 2,
    ),
  ]);

  static final ValueNotifier<String?> appliedPromoNotifier =
      ValueNotifier<String?>(null);

  static final ValueNotifier<double> discountNotifier =
      ValueNotifier<double>(0.0);

  /// Current cart items
  static List<CartItemModel> get items => itemsNotifier.value;

  /// Total count of all units in cart
  static int get totalCount =>
      items.fold(0, (sum, item) => sum + item.quantity);

  /// Subtotal before delivery and discounts
  static double get subtotal =>
      items.fold(0.0, (sum, item) => sum + item.totalPrice);

  /// Standard delivery fee (Free for orders over 150)
  static double get deliveryFee =>
      items.isEmpty ? 0.0 : (subtotal > 150 ? 0.0 : 15.0);

  /// Estimated tax / VAT (5%)
  static double get tax => items.isEmpty ? 0.0 : (subtotal * 0.05);

  /// Total discount amount
  static double get discount => discountNotifier.value;

  /// Grand Total
  static double get grandTotal {
    if (items.isEmpty) return 0.0;
    final total = subtotal + deliveryFee + tax - discount;
    return total < 0 ? 0.0 : total;
  }

  /// Check if a product is in cart
  static bool isInCart(String productId) {
    return items.any((item) => item.product.id == productId);
  }

  /// Get current quantity of a specific product
  static int getQuantity(String productId) {
    final index = items.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      return items[index].quantity;
    }
    return 0;
  }

  /// Add item or increase quantity
  static void addItem(ProductModel product, {int quantity = 1, String? notes}) {
    if (quantity <= 0) return;
    final currentList = List<CartItemModel>.from(items);
    final index = currentList.indexWhere((item) => item.product.id == product.id);

    if (index >= 0) {
      final existing = currentList[index];
      currentList[index] = existing.copyWith(
        quantity: existing.quantity + quantity,
        notes: notes ?? existing.notes,
      );
    } else {
      currentList.add(CartItemModel(
        product: product,
        quantity: quantity,
        notes: notes,
      ));
    }
    itemsNotifier.value = currentList;
  }

  /// Remove item completely
  static void removeItem(String productId) {
    final currentList = List<CartItemModel>.from(items);
    currentList.removeWhere((item) => item.product.id == productId);
    itemsNotifier.value = currentList;
    if (itemsNotifier.value.isEmpty) {
      removePromoCode();
    }
  }

  /// Set exact quantity
  static void updateQuantity(String productId, int quantity) {
    if (quantity <= 0) {
      removeItem(productId);
      return;
    }
    final currentList = List<CartItemModel>.from(items);
    final index = currentList.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      currentList[index] = currentList[index].copyWith(quantity: quantity);
      itemsNotifier.value = currentList;
    }
  }

  /// Increment quantity by 1
  static void increment(String productId) {
    final currentList = List<CartItemModel>.from(items);
    final index = currentList.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      currentList[index] = currentList[index].copyWith(
        quantity: currentList[index].quantity + 1,
      );
      itemsNotifier.value = currentList;
    }
  }

  /// Decrement quantity by 1
  static void decrement(String productId) {
    final currentList = List<CartItemModel>.from(items);
    final index = currentList.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      if (currentList[index].quantity > 1) {
        currentList[index] = currentList[index].copyWith(
          quantity: currentList[index].quantity - 1,
        );
        itemsNotifier.value = currentList;
      } else {
        removeItem(productId);
      }
    }
  }

  /// Clear all cart contents
  static void clearCart() {
    itemsNotifier.value = [];
    removePromoCode();
  }

  /// Apply promo code
  static bool applyPromoCode(String code) {
    final cleanCode = code.trim().toUpperCase();
    if (cleanCode == 'SAVE20' || cleanCode == 'OFFER20') {
      appliedPromoNotifier.value = cleanCode;
      discountNotifier.value = subtotal * 0.20; // 20% discount
      return true;
    } else if (cleanCode == 'FREE' || cleanCode == 'DELIVERY') {
      appliedPromoNotifier.value = cleanCode;
      discountNotifier.value = deliveryFee; // Free delivery
      return true;
    } else if (cleanCode == 'MEAL10') {
      appliedPromoNotifier.value = cleanCode;
      discountNotifier.value = 10.0;
      return true;
    }
    return false;
  }

  /// Remove promo code
  static void removePromoCode() {
    appliedPromoNotifier.value = null;
    discountNotifier.value = 0.0;
  }
}
