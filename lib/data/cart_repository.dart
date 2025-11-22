// lib/data/cart_repository.dart

import 'package:flutter/material.dart';

// 1. MÔ HÌNH DỮ LIỆU CART ITEM
class CartItem {
  final String name;
  final double price;
  int quantity;
  final String size;
  final String color;

  CartItem({
    required this.name,
    required this.price,
    this.quantity = 1,
    required this.size,
    required this.color,
  });

  // Tạo hàm copy để dễ dàng cập nhật số lượng
  CartItem copyWith({
    int? quantity,
  }) {
    return CartItem(
      name: name,
      price: price,
      quantity: quantity ?? this.quantity,
      size: size,
      color: color,
    );
  }
}

// 2. KHO LƯU TRỮ (SINGLETON REPOSITORY)
class CartRepository extends ChangeNotifier {
  // Singleton Pattern
  static final CartRepository _instance = CartRepository._internal();
  factory CartRepository() => _instance;
  CartRepository._internal();

  // Danh sách giỏ hàng thực tế
  final List<CartItem> _cartItems = [];

  // Getter (Lấy bản sao của danh sách)
  List<CartItem> get items => List.unmodifiable(_cartItems);

  // Thêm sản phẩm vào giỏ hàng
  void addItem(String name, double price, String size, String color) {
    // Kiểm tra nếu sản phẩm đã tồn tại (cùng tên, size, màu)
    final existingIndex = _cartItems.indexWhere(
          (item) => item.name == name && item.size == size && item.color == color,
    );

    if (existingIndex >= 0) {
      // Nếu đã tồn tại, tăng số lượng
      _cartItems[existingIndex] = _cartItems[existingIndex].copyWith(
        quantity: _cartItems[existingIndex].quantity + 1,
      );
    } else {
      // Nếu chưa, thêm mới
      _cartItems.add(CartItem(
        name: name,
        price: price,
        size: size,
        color: color,
        quantity: 1,
      ));
    }
    // Thông báo cho các widget lắng nghe (CartScreen) cập nhật giao diện
    notifyListeners();
  }

  // Cập nhật số lượng
  void updateQuantity(CartItem item, int newQuantity) {
    final index = _cartItems.indexWhere(
          (i) => i.name == item.name && i.size == item.size && i.color == item.color,
    );

    if (index >= 0) {
      if (newQuantity <= 0) {
        _cartItems.removeAt(index);
      } else {
        _cartItems[index] = _cartItems[index].copyWith(quantity: newQuantity);
      }
      notifyListeners();
    }
  }

  // THÊM HÀM MỚI: Xóa toàn bộ sản phẩm trong giỏ hàng
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}