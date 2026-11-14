import 'package:flutter/foundation.dart';
import 'package:restaurant/models/product_model.dart';

/// Represents an item added to the user's shopping cart.
@immutable
class CartItemModel {
  final ProductModel product;
  final int quantity;
  final String? notes;

  const CartItemModel({
    required this.product,
    this.quantity = 1,
    this.notes,
  });

  /// Total price for this cart line item
  double get totalPrice => product.price * quantity;

  CartItemModel copyWith({
    ProductModel? product,
    int? quantity,
    String? notes,
  }) {
    return CartItemModel(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      notes: notes ?? this.notes,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItemModel &&
          runtimeType == other.runtimeType &&
          product.id == other.product.id &&
          quantity == other.quantity &&
          notes == other.notes;

  @override
  int get hashCode => Object.hash(product.id, quantity, notes);
}
