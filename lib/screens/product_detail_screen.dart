// lib/screens/product_detail_screen.dart

import 'package:flutter/material.dart';
import '../data/cart_repository.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productName;

  const ProductDetailScreen({super.key, required this.productName});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String? _selectedSize;
  String? _selectedColor;

  final List<String> _availableSizes = ['S', 'M', 'L', 'XL'];
  final List<Color> _availableColors = [Colors.red, Colors.blue, Colors.black, Colors.white];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productName),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          // Nội dung chi tiết cuộn được
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 100), // Dành không gian cho nút cố định
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- 1. Ảnh sản phẩm (Placeholder) ---
                _buildProductImagePlaceholder(),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- 2. Tên & Giá ---
                      Text(
                        widget.productName,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '500.000 VNĐ',
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: Colors.red
                        ),
                      ),
                      const SizedBox(height: 15),

                      // --- 3. Lựa chọn Kích cỡ ---
                      _buildOptionSelector('Kích cỡ:', _availableSizes, _selectedSize, (size) {
                        setState(() {
                          _selectedSize = size;
                        });
                      }),
                      const SizedBox(height: 15),

                      // --- 4. Lựa chọn Màu sắc ---
                      _buildColorSelector(),
                      const SizedBox(height: 20),

                      // --- 5. Mô tả sản phẩm ---
                      _buildDescriptionSection(),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // --- 6. Nút "Thêm vào Giỏ hàng" (Cố định ở dưới) ---
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildAddToCartButton(context),
          ),
        ],
      ),
    );
  }

  // Widget Placeholder ảnh
  Widget _buildProductImagePlaceholder() {
    return Container(
      height: 350,
      width: double.infinity,
      color: Colors.grey.shade200,
      alignment: Alignment.center,
      child: Icon(Icons.dry_cleaning, size: 100, color: Colors.deepPurple.shade300),
    );
  }

  // Widget Lựa chọn (Size)
  Widget _buildOptionSelector(
      String title, List<String> options, String? selectedValue, ValueChanged<String> onSelected) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title ${selectedValue != null ? '(${selectedValue})' : ''}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 10.0,
          children: options.map((option) {
            final isSelected = option == selectedValue;
            return ChoiceChip(
              label: Text(option),
              selected: isSelected,
              selectedColor: Colors.deepPurple.shade100,
              backgroundColor: Colors.grey.shade100,
              labelStyle: TextStyle(
                color: isSelected ? Colors.deepPurple : Colors.black87,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              onSelected: (selected) {
                if (selected) {
                  onSelected(option);
                }
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  // Widget Lựa chọn Màu sắc
  Widget _buildColorSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Màu sắc: ${_selectedColor != null ? '(${_selectedColor!})' : ''}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 10.0,
          children: _availableColors.map((color) {
            final colorName = _getColorName(color);
            final isSelected = colorName == _selectedColor;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = colorName;
                });
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? Colors.deepPurple : Colors.grey.shade300,
                    width: isSelected ? 3.0 : 1.0,
                  ),
                  boxShadow: isSelected ? [
                    BoxShadow(color: Colors.deepPurple.withOpacity(0.5), blurRadius: 4)
                  ] : null,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // Hàm chuyển đổi Color sang Tên
  String _getColorName(Color color) {
    if (color == Colors.red) return 'Đỏ';
    if (color == Colors.blue) return 'Xanh Dương';
    if (color == Colors.black) return 'Đen';
    if (color == Colors.white) return 'Trắng';
    return 'Khác';
  }

  // Widget Mô tả sản phẩm
  Widget _buildDescriptionSection() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mô tả chi tiết',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Chất liệu vải cao cấp, mềm mại, thoáng mát, mang lại cảm giác thoải mái khi mặc. Thiết kế hiện đại, dễ dàng phối hợp với nhiều loại trang phục khác nhau. Phù hợp cho mọi dịp, từ đi làm đến đi chơi.',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),
        SizedBox(height: 10),
        Text(
          '• Chất liệu: Cotton 100%',
          style: TextStyle(fontSize: 15),
        ),
        Text(
          '• Xuất xứ: Việt Nam',
          style: TextStyle(fontSize: 15),
        ),
      ],
    );
  }

  // Widget Nút Thêm vào Giỏ hàng
  Widget _buildAddToCartButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          icon: const Icon(Icons.add_shopping_cart, color: Colors.white),
          label: const Text(
            'THÊM VÀO GIỎ HÀNG',
            style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15),
            backgroundColor: Colors.deepPurple,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: () {
            if (_selectedSize == null || _selectedColor == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Vui lòng chọn Kích cỡ và Màu sắc.')),
              );
              return;
            }

            // LOGIC THÊM SẢN PHẨM VÀO REPOSITORY
            CartRepository().addItem(
              widget.productName,
              500000.0, // Giá giả lập
              _selectedSize!,
              _getColorName(
                  _availableColors.firstWhere((c) => _getColorName(c) == _selectedColor)
              ),
            );

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Đã thêm ${widget.productName} (Size: $_selectedSize) vào giỏ hàng!'),
                duration: const Duration(seconds: 2),
              ),
            );
          },
        ),
      ),
    );
  }
}