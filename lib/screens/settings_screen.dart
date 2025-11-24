// lib/screens/settings_screen.dart

import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cài đặt chung'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          // Mục 1: Chỉnh sửa hồ sơ (Đã được chuyển vào đây)
          _buildSettingsItem(
            context,
            icon: Icons.person_outline,
            title: 'Chỉnh sửa hồ sơ',
            onTap: () {
              // TODO: Điều hướng đến ProfileEditScreen
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Điều hướng đến Chỉnh sửa hồ sơ')),
              );
            },
          ),
          const Divider(height: 1),
          // Mục 2: Sổ địa chỉ (Đã được chuyển vào đây)
          _buildSettingsItem(
            context,
            icon: Icons.location_on_outlined,
            title: 'Sổ địa chỉ',
            onTap: () {
              // TODO: Điều hướng đến AddressBookScreen
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Điều hướng đến Sổ địa chỉ')),
              );
            },
          ),
          const Divider(height: 1),
          // Thêm các cài đặt khác nếu cần
        ],
      ),
    );
  }

  // Widget dùng chung cho các mục cài đặt
  Widget _buildSettingsItem(
      BuildContext context, {
        required IconData icon,
        required String title,
        required VoidCallback onTap,
      }) {
    return ListTile(
      leading: Icon(icon, color: Colors.deepPurple),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}