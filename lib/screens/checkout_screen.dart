// lib/screens/checkout_screen.dart

import 'package:flutter/material.dart';
import '../data/cart_repository.dart';
// THÊM IMPORT MÀN HÌNH MỚI
import 'address_edit_screen.dart';

class CheckoutScreen extends StatefulWidget {
  final List<CartItem> cartItems;

  const CheckoutScreen({super.key, required this.cartItems});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  // Trạng thái giả lập cho các trường
  String _selectedPaymentMethod = 'COD'; // Mặc định là COD
  final String _shippingAddress = "Tòa nhà ABC, 123 Đường XYZ, Phường 1, Quận 1, TP.HCM";
  final String _defaultPhone = "0901 234 567";

  double get _subtotal {
    return widget.cartItems.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }

  final double _shippingFee = 30000; // Phí vận chuyển cố định

  double get _total {
    return _subtotal + _shippingFee;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thanh Toán'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- A. Địa chỉ Giao hàng ---
                  _buildSectionHeader('1. Địa chỉ Giao hàng 🏠'),
                  _buildShippingAddressCard(),
                  const SizedBox(height: 20),

                  // --- B. Phương thức Thanh toán ---
                  _buildSectionHeader('2. Phương thức Thanh toán 💳'),
                  _buildPaymentMethodSelector(),
                  const SizedBox(height: 20),

                  // --- C. Tóm tắt Đơn hàng ---
                  _buildSectionHeader('3. Tóm tắt Đơn hàng 📦'),
                  _buildOrderSummaryList(),
                ],
              ),
            ),
          ),
          // --- D. Footer Tổng cộng và Đặt hàng ---
          _buildCheckoutFooter(context),
        ],
      ),
    );
  }

  // Widget Tiêu đề phân mục
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple),
      ),
    );
  }

  // Widget Card Địa chỉ Giao hàng (ĐÃ SỬA LOGIC ONTAP)
  Widget _buildShippingAddressCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        leading: const Icon(Icons.location_on_outlined, color: Colors.deepPurple),
        title: const Text('Địa chỉ nhận hàng', style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(_shippingAddress),
            Text(_defaultPhone),
          ],
        ),
        trailing: const Icon(Icons.edit, color: Colors.grey),
        onTap: () {
          // THÊM LOGIC ĐIỀU HƯỚNG TỚI MÀN HÌNH CHỈNH SỬA
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddressEditScreen()),
          );
        },
      ),
    );
  }

  // Widget Chọn Phương thức Thanh toán
  Widget _buildPaymentMethodSelector() {
    return Column(
      children: [
        _buildPaymentOption('Thanh toán khi nhận hàng (COD)', 'COD', Icons.delivery_dining),
        _buildPaymentOption('Chuyển khoản Ngân hàng', 'BankTransfer', Icons.credit_card),
        _buildPaymentOption('Ví điện tử (Momo/ZaloPay)', 'EWallet', Icons.phone_android),
      ],
    );
  }

  // Widget Tùy chọn Thanh toán đơn lẻ
  Widget _buildPaymentOption(String title, String value, IconData icon) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: RadioListTile<String>(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        secondary: Icon(icon, color: Colors.deepPurple),
        value: value,
        groupValue: _selectedPaymentMethod,
        onChanged: (String? val) {
          setState(() {
            _selectedPaymentMethod = val!;
          });
        },
        activeColor: Colors.deepPurple,
      ),
    );
  }

  // Widget Danh sách Tóm tắt Đơn hàng (Các sản phẩm)
  Widget _buildOrderSummaryList() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widget.cartItems.map((item) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '${item.name} (${item.size}, ${item.color}) x ${item.quantity}',
                    style: const TextStyle(fontSize: 15, color: Colors.black87),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${(item.price * item.quantity).toStringAsFixed(0)} VNĐ',
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  // Widget Footer Tổng cộng và Nút Đặt hàng
  Widget _buildCheckoutFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildPriceRow('Tạm tính:', _subtotal, color: Colors.black87),
            _buildPriceRow('Phí vận chuyển:', _shippingFee, color: Colors.black87),
            const Divider(height: 15),
            _buildPriceRow('TỔNG CỘNG:', _total, isTotal: true),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  // 1. Logic xử lý Đặt hàng
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Đặt hàng thành công! Thanh toán bằng $_selectedPaymentMethod')),
                  );

                  // 2. XÓA GIỎ HÀNG
                  CartRepository().clearCart();

                  // 3. QUAY LẠI MÀN HÌNH TRƯỚC (CartScreen)
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'XÁC NHẬN ĐẶT HÀNG',
                  style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget Dòng hiển thị giá
  Widget _buildPriceRow(String label, double amount, {bool isTotal = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: color ?? Colors.deepPurple,
            ),
          ),
          Text(
            '${amount.toStringAsFixed(0)} VNĐ',
            style: TextStyle(
              fontSize: isTotal ? 22 : 16,
              fontWeight: isTotal ? FontWeight.w900 : FontWeight.w600,
              color: isTotal ? Colors.red : color,
            ),
          ),
        ],
      ),
    );
  }
}