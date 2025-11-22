// lib/screens/account_screen.dart

import 'package:flutter/material.dart';

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
                  _buildAccountItem(context, Icons.person_outline, 'Chỉnh sửa hồ sơ', () {}),
                  _buildAccountItem(context, Icons.location_on_outlined, 'Sổ địa chỉ', () {}),
                  _buildAccountItem(context, Icons.settings_outlined, 'Cài đặt chung', () {}),

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

  // Widget Header thông tin người dùng
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 50, color: Colors.deepPurple),
          ),
          const SizedBox(height: 10),
          const Text(
            'Xin chào, Khách hàng!',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 4),
          Text(
            'customer@example.com',
            style: TextStyle(fontSize: 16, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  // Widget Tiêu đề phân mục
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

  // Widget Tùy chọn tài khoản (Profile Item)
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Chuyển đến $title')),
          );
          onTap();
        },
      ),
    );
  }

  // Widget Nút Đăng xuất
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
          // TODO: Chuyển hướng về màn hình Đăng nhập (AuthScreen)
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Đang đăng xuất...')),
          );
        },
      ),
    );
  }
}