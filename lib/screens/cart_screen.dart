// lib/screens/cart_screen.dart

import 'package:flutter/material.dart';
import 'checkout_screen.dart';
import '../data/cart_repository.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartRepository _cartRepository = CartRepository();

  @override
  void initState() {
    super.initState();
    // BẮT ĐẦU LẮNG NGHE thay đổi từ repository
    _cartRepository.addListener(_onCartChanged);
  }

  @override
  void dispose() {
    // NGỪNG LẮNG NGHE khi widget bị hủy
    _cartRepository.removeListener(_onCartChanged);
    super.dispose();
  }

  void _onCartChanged() {
    // Gọi setState khi dữ liệu giỏ hàng thay đổi
    setState(() {});
  }

  // Lấy danh sách sản phẩm từ Repository
  List<CartItem> get cartItems => _cartRepository.items;

  // Hàm tính tổng tiền (Sử dụng getter)
  double get subtotal {
    return cartItems.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }

  // Hàm điều chỉnh số lượng (Sử dụng repository)
  void _updateQuantity(CartItem item, int delta) {
    _cartRepository.updateQuantity(item, item.quantity + delta);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: cartItems.isEmpty
          ? _buildEmptyCart()
          : Column(
        children: [
          // --- 1. Danh sách các sản phẩm ---
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return _buildCartItemCard(context, cartItems[index]);
              },
            ),
          ),

          // --- 2. Tổng thanh toán và Nút Thanh toán ---
          _buildCheckoutSummary(context),
        ],
      ),
    );
  }

  // Widget hiển thị giỏ hàng trống
  Widget _buildEmptyCart() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'Giỏ hàng của bạn đang trống!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 8),
          Text('Hãy quay lại Trang chủ để khám phá sản phẩm.'),
        ],
      ),
    );
  }

  // Widget cho mỗi item trong giỏ hàng
  Widget _buildCartItemCard(BuildContext context, CartItem item) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ảnh sản phẩm (Placeholder)
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.style, color: Colors.deepPurple, size: 40),
            ),
            const SizedBox(width: 10),

            // Thông tin sản phẩm
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${item.size} | ${item.color}',
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${item.price.toStringAsFixed(0)} VNĐ',
                    style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            // Điều chỉnh số lượng
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildQuantityControl(item),
                const SizedBox(height: 10),
                // Nút xóa sản phẩm
                InkWell(
                  onTap: () => _updateQuantity(item, -item.quantity),
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Text(
                      'Xóa',
                      style: TextStyle(color: Colors.red, fontSize: 13),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget Điều chỉnh số lượng
  Widget _buildQuantityControl(CartItem item) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _quantityButton(Icons.remove, () => _updateQuantity(item, -1)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              item.quantity.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          _quantityButton(Icons.add, () => _updateQuantity(item, 1)),
        ],
      ),
    );
  }

  // Widget nút + / -
  Widget _quantityButton(IconData icon, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Icon(icon, size: 20, color: Colors.deepPurple),
      ),
    );
  }

  // Widget tóm tắt thanh toán
  Widget _buildCheckoutSummary(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Tạm tính:', style: TextStyle(fontSize: 16)),
                Text(
                  '${subtotal.toStringAsFixed(0)} VNĐ',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Tổng thanh toán:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(
                  '${subtotal.toStringAsFixed(0)} VNĐ',
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.deepPurple),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  // Logic điều hướng sang màn hình Thanh toán
                  if (cartItems.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Giỏ hàng trống. Vui lòng thêm sản phẩm.')),
                    );
                    return;
                  }

                  // Điều hướng sang màn hình Thanh toán và truyền dữ liệu sản phẩm
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CheckoutScreen(cartItems: cartItems),
                    ),
                  );
                },
                child: const Text(
                  'TIẾN HÀNH ĐẶT HÀNG',
                  style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}