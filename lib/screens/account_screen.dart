// lib/screens/account_screen.dart

import 'package:flutter/material.dart';
// 1. IMPORT MÀN HÌNH CÀI ĐẶT MỚI
import 'settings_screen.dart';
// IMPORT MÀN HÌNH ĐĂNG NHẬP/ĐĂNG KÝ (GIẢ ĐỊNH TÊN FILE LÀ auth_screen.dart)
// Hãy đảm bảo file này tồn tại trong thư mục screens/
import 'auth_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- 1. Khu vực Thông tin Hồ sơ (Header) ---
            _buildProfileHeader(context),

            // --- 2. Các Tùy chọn chính ---
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  _buildSectionTitle('Quản Lý Đơn Hàng'),
                  _buildAccountItem(context, Icons.shopping_bag_outlined, 'Đơn hàng của tôi', () {}),
                  _buildAccountItem(context, Icons.favorite_border, 'Sản phẩm yêu thích', () {}),

                  const SizedBox(height: 15),
                  _buildSectionTitle('Thông Tin Tài Khoản'),

                  // SỬA LOGIC ONTAP cho Cài đặt chung
                  _buildAccountItem(
                    context,
                    Icons.settings_outlined,
                    'Cài đặt chung',
                        () {
                      // ĐIỀU HƯỚNG TỚI MÀN HÌNH SETTINGS MỚI
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SettingsScreen()),
                      );
                    },
                  ),

                  const SizedBox(height: 20),
                  // --- 3. Nút Đăng xuất ---
                  _buildLogoutButton(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget Header thông tin người dùng (Không thay đổi)
  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 40, bottom: 20, left: 20, right: 20),
      decoration: BoxDecoration(
        color: Colors.deepPurple,
        boxShadow: [
          BoxShadow(color: Colors.deepPurple.shade900.withOpacity(0.3), blurRadius: 10),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 50, color: Colors.deepPurple),
          ),
          SizedBox(height: 10),
          Text(
            'Xin chào, Khách hàng!',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 4),
          Text(
            'customer@example.com',
            style: TextStyle(fontSize: 16, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  // Widget Tiêu đề phân mục (Không thay đổi)
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 8.0, left: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade600,
          ),
        ),
      ),
    );
  }

  // Widget Tùy chọn tài khoản (Đã sửa logic onTap để không hiển thị SnackBar khi điều hướng)
  Widget _buildAccountItem(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        leading: Icon(icon, color: Colors.deepPurple),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: () {
          // Bỏ SnackBar mặc định nếu item là 'Cài đặt chung'
          if (title != 'Cài đặt chung') {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Chuyển đến $title')),
            );
          }
          onTap();
        },
      ),
    );
  }

  // Widget Nút Đăng xuất (ĐÃ THAY THẾ LOGIC ĐIỀU HƯỚNG)
  Widget _buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        icon: const Icon(Icons.logout, color: Colors.red),
        label: const Text('ĐĂNG XUẤT', style: TextStyle(fontSize: 16, color: Colors.red)),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12),
          side: const BorderSide(color: Colors.red, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: () {
          // 1. Hiển thị thông báo đăng xuất
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Đang đăng xuất...')),
          );

          // 2. Điều hướng về màn hình Đăng nhập (AuthScreen) và xóa tất cả route cũ
          // THAY THẾ 'AuthScreen' bằng tên class màn hình Đăng nhập/Đăng ký của bạn
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const AuthScreen(),
            ),
                (Route<dynamic> route) => false, // Xóa tất cả các route trước đó
          );
        },
      ),
    );
  }
}