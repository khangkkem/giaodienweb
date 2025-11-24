// lib/screens/home_tab.dart (Phiên bản đã thêm Shop Info Footer)

import 'package:flutter/material.dart';
import 'product_detail_screen.dart'; // Import để điều hướng

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Sử dụng ListView để toàn bộ nội dung Trang chủ có thể cuộn
    return ListView(
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      children: <Widget>[
        // --- 1. Banner Quảng Cáo (Sử dụng PageView để giả lập Slider) ---
        _buildBannerSliderPlaceholder(),
        const SizedBox(height: 25),

        // --- 2. Danh Mục Nổi Bật ---
        _buildSectionHeader('Danh Mục Nổi Bật 🛍️', context),
        const SizedBox(height: 10),
        _buildCategoryList(),
        const SizedBox(height: 25),

        // --- 3. Sản Phẩm Bán Chạy (Cuộn ngang) ---
        _buildSectionHeader('Sản Phẩm Bán Chạy 🔥', context),
        const SizedBox(height: 10),
        _buildTrendingProductsList(context), // Truyền context
        const SizedBox(height: 25),

        // --- 4. Khám Phá Thêm (Sản phẩm dạng lưới) ---
        _buildSectionHeader('Khám Phá Thêm ✨', context),
        const SizedBox(height: 10),
        _buildProductGrid(context), // Truyền context
        const SizedBox(height: 30),

        // --- 5. FOOTER THÔNG TIN CỬA HÀNG ---
        _buildShopInfoFooter(context),
      ],
    );
  }

  // --- WIDGET CHỨC NĂNG RIÊNG ---

  // Widget Footer Thông tin Cửa hàng MỚI
  Widget _buildShopInfoFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.deepPurple.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'THÔNG TIN CỬA HÀNG FASHION STORE',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const Divider(color: Colors.deepPurple, height: 20),
          _buildInfoRow(Icons.location_on_outlined, 'Địa chỉ:', '123 Đường XYZ, Quận 1, TP.HCM'),
          _buildInfoRow(Icons.phone_outlined, 'Hotline:', '0901 234 567 (8h - 22h)'),
          _buildInfoRow(Icons.email_outlined, 'Email:', 'support@fashionstore.vn'),
          const SizedBox(height: 15),
          const Center(
            child: Text(
              '© 2025 Fashion Store. All Rights Reserved.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  // Widget dòng thông tin phụ trợ
  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: Colors.deepPurple.shade700),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  // 1. Banner Slider (Sử dụng PageView để giả lập)
  Widget _buildBannerSliderPlaceholder() {
    return SizedBox(
      height: 160.0,
      child: PageView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          final List<Map<String, dynamic>> banners = [
            {'title': 'SALE 50% TOÀN BỘ SẢN PHẨM', 'color': Colors.deepPurple.shade400},
            {'title': 'BST MÙA ĐÔNG ẤM ÁP', 'color': Colors.pink.shade400},
            {'title': 'Freeship mọi đơn hàng', 'color': Colors.teal.shade400},
          ];

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: banners[index]['color'],
              boxShadow: [
                BoxShadow(color: (banners[index]['color'] as Color).withOpacity(0.4), blurRadius: 8),
              ],
            ),
            child: Center(
              child: Text(
                banners[index]['title'] as String,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // 2. Header Section (Tiêu đề và Xem thêm)
  Widget _buildSectionHeader(String title, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Chuyển đến trang ${title.split(' ')[0]}')),
              );
            },
            child: const Text('Xem thêm >', style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  // 3. Danh sách Danh mục (Cuộn ngang)
  Widget _buildCategoryList() {
    final List<Map<String, dynamic>> categories = [
      {'icon': Icons.checkroom, 'name': 'Áo Thun'},
      {'icon': Icons.accessibility, 'name': 'Quần Jeans'},
      {'icon': Icons.watch, 'name': 'Phụ kiện'},
      {'icon': Icons.storefront, 'name': 'Váy Đầm'},
      {'icon': Icons.wallet, 'name': 'Túi Xách'},
    ];

    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () {
                // TODO: Chuyển đến trang danh mục chi tiết
              },
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.deepPurple.shade50,
                    child: Icon(categories[index]['icon'], color: Colors.deepPurple, size: 30),
                  ),
                  const SizedBox(height: 5),
                  Text(categories[index]['name']!, style: const TextStyle(fontSize: 12, color: Colors.black87)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // 4. Sản Phẩm Bán Chạy (Cuộn ngang)
  Widget _buildTrendingProductsList(BuildContext context) {
    final List<String> trendingProducts = List.generate(5, (i) => 'Hot Item ${i + 1}');

    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: trendingProducts.length,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: _buildProductItem(context, trendingProducts[index], isHorizontal: true),
          );
        },
      ),
    );
  }

  // 5. Khám Phá Thêm (Grid View)
  Widget _buildProductGrid(BuildContext context) {
    final List<String> products = List.generate(8, (i) => 'Sản phẩm mới ${i + 1}');

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(), // Đảm bảo ListView cha quản lý cuộn
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.65,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return _buildProductItem(context, products[index]);
      },
    );
  }

  // 6. Widget giao diện của 1 sản phẩm (Đã cập nhật điều hướng)
  Widget _buildProductItem(BuildContext context, String productName, {bool isHorizontal = false}) {
    return Container(
      width: isHorizontal ? 160 : null,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          // Điều hướng đến màn hình Chi tiết Sản phẩm
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailScreen(productName: productName),
            ),
          );
        },
        borderRadius: BorderRadius.circular(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ảnh sản phẩm Placeholder
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
              child: Container(
                height: isHorizontal ? 150 : 180,
                width: double.infinity,
                color: Colors.grey.shade100,
                alignment: Alignment.center,
                child: Icon(Icons.dry_cleaning, size: isHorizontal ? 60 : 80, color: Colors.deepPurple.shade300),
              ),
            ),

            // Chi tiết sản phẩm
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '500.000 VNĐ',
                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.w800, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 14),
                      const Text('4.8 |', style: TextStyle(fontSize: 12, color: Colors.black54)),
                      const Text(' Đã bán 120', style: TextStyle(fontSize: 12, color: Colors.black54)),
                      const Spacer(),
                      if (!isHorizontal)
                        Icon(Icons.add_shopping_cart, color: Colors.deepPurple, size: 20),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}