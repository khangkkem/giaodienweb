// lib/screens/product_detail_screen.dart (Phiên bản có form đánh giá)

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

  // --- Dữ liệu đánh giá giả lập ---
  final List<Map<String, dynamic>> _dummyReviews = [
    {'user': 'Nguyễn Văn A', 'rating': 5, 'comment': 'Sản phẩm chất lượng cao, giao hàng nhanh chóng!', 'date': '10/11/2025'},
    {'user': 'Trần Thị B', 'rating': 4, 'comment': 'Vải đẹp, form chuẩn. Nhưng hơi rộng so với size M bình thường.', 'date': '08/11/2025'},
    {'user': 'Lê Văn C', 'rating': 5, 'comment': 'Hoàn hảo!', 'date': '05/11/2025'},
    {'user': 'Phạm Thị D', 'rating': 3, 'comment': 'Màu sắc không giống lắm so với ảnh.', 'date': '01/11/2025'},
  ];

  final double _averageRating = 4.8;
  final int _totalReviewCount = 120;


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
                      const SizedBox(height: 20),
                    ],
                  ),
                ),

                // --- 6. PHẦN ĐÁNH GIÁ (REVIEW SECTION) ---
                _buildReviewSection(),
                const SizedBox(height: 20),
              ],
            ),
          ),

          // --- 7. Nút "Thêm vào Giỏ hàng" (Cố định ở dưới) ---
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

  // Widget Phần Đánh giá (REVIEW SECTION)
  Widget _buildReviewSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tiêu đề Đánh giá và Điểm số trung bình
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Đánh giá Sản phẩm',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 20),
                  Text(
                    ' $_averageRating/5 (${_totalReviewCount} reviews)',
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ],
              ),
            ],
          ),
          const Divider(height: 20),

          // Tóm tắt Rating và Thanh tiến trình
          _buildRatingSummary(),
          const SizedBox(height: 15),

          // Nút Viết Đánh Giá
          _buildLeaveReviewButton(),
          const SizedBox(height: 15),

          // Danh sách các Review (chỉ hiển thị vài cái đầu)
          Text(
            'Nhận xét từ khách hàng:',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.deepPurple),
          ),
          const SizedBox(height: 10),
          ..._dummyReviews.take(3).map((review) => _buildReviewItem(review)).toList(),

          // Nút xem tất cả
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Chuyển đến trang Tất cả Đánh giá')),
                );
              },
              child: Text(
                'Xem tất cả $_totalReviewCount đánh giá >',
                style: const TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget Tóm tắt Rating
  Widget _buildRatingSummary() {
    // Giả lập số lượng đánh giá cho từng sao
    final Map<int, int> starCounts = {
      5: 80,
      4: 30,
      3: 8,
      2: 2,
      1: 0,
    };

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Điểm trung bình lớn
        Column(
          children: [
            Text(
                '${_averageRating.toStringAsFixed(1)}',
                style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w900, color: Colors.deepPurple)
            ),
            Row(children: List.generate(5, (index) {
              if (index < _averageRating.floor()) {
                return const Icon(Icons.star, color: Colors.amber, size: 18);
              } else if (index < _averageRating) {
                return const Icon(Icons.star_half, color: Colors.amber, size: 18);
              } else {
                return Icon(Icons.star_border, color: Colors.grey.shade400, size: 18);
              }
            })),
            Text(
                '$_totalReviewCount reviews',
                style: const TextStyle(fontSize: 13, color: Colors.black54)
            ),
          ],
        ),
        const SizedBox(width: 25),
        // Biểu đồ rating
        Expanded(
          child: Column(
            children: starCounts.entries.map((entry) => _buildRatingBar(entry.key, entry.value)).toList(),
          ),
        ),
      ],
    );
  }

  // Widget Thanh tiến trình cho Rating
  Widget _buildRatingBar(int star, int count) {
    double percent = count / _totalReviewCount;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Text('$star ⭐', style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 8),
          Expanded(
            child: LinearProgressIndicator(
              value: percent,
              backgroundColor: Colors.grey.shade200,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 8),
          Text('$count', style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  // Widget hiển thị 1 mục Review
  Widget _buildReviewItem(Map<String, dynamic> review) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                review['user'] as String,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              Text(
                review['date'] as String,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: List.generate(
              review['rating'] as int,
                  (index) => const Icon(Icons.star, color: Colors.amber, size: 16),
            ),
          ),
          const SizedBox(height: 4),
          Text(review['comment'] as String, style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 8),
          const Divider(height: 1),
        ],
      ),
    );
  }

  // --- WIDGET VÀ HÀM CHO PHẦN VIẾT ĐÁNH GIÁ MỚI ---

  // Widget Nút Viết Đánh Giá
  Widget _buildLeaveReviewButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        icon: const Icon(Icons.rate_review, color: Colors.deepPurple),
        label: const Text('VIẾT ĐÁNH GIÁ CỦA BẠN', style: TextStyle(fontSize: 16, color: Colors.deepPurple)),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12),
          side: const BorderSide(color: Colors.deepPurple, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: () => _showReviewForm(context),
      ),
    );
  }

  // Hàm hiển thị Modal Bottom Sheet
  void _showReviewForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Cho phép cuộn để tránh bàn phím che mất
      builder: (context) {
        // Wrap trong Padding cho bàn phím
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: _buildReviewForm(context),
        );
      },
    );
  }

  // Widget Form Viết Đánh Giá
  Widget _buildReviewForm(BuildContext context) {
    // State cục bộ cho rating trong BottomSheet
    int currentRating = 5;

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setModalState) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Đánh giá sản phẩm ${widget.productName}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple),
              ),
              const Divider(),
              const SizedBox(height: 10),

              // Chọn Rating
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(5, (index) {
                    return IconButton(
                      icon: Icon(
                        index < currentRating ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                        size: 35,
                      ),
                      onPressed: () {
                        setModalState(() {
                          currentRating = index + 1; // 1-based index
                        });
                      },
                    );
                  }),
                ),
              ),
              const SizedBox(height: 20),

              // Nhập Bình luận
              const TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Bình luận của bạn',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              // Nút Gửi Đánh Giá
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Đóng modal
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Đã gửi đánh giá $currentRating sao cho ${widget.productName}')),
                    );
                    // TODO: Logic gửi dữ liệu đánh giá (rating, comment) lên server
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text('GỬI ĐÁNH GIÁ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        );
      },
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
      child: SafeArea(
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
      ),
    );
  }
}