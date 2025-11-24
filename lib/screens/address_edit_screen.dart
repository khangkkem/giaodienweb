// lib/screens/address_edit_screen.dart

import 'package:flutter/material.dart';

class AddressEditScreen extends StatelessWidget {
  const AddressEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chỉnh Sửa Địa Chỉ'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Vui lòng nhập thông tin nhận hàng:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ),
            const SizedBox(height: 15),

            // Trường Tên người nhận (Giả lập)
            const TextField(
              decoration: InputDecoration(
                labelText: 'Tên người nhận',
                prefixIcon: Icon(Icons.person_outline),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            // Trường Số điện thoại (Giả lập)
            const TextField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Số điện thoại',
                prefixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            // Trường Địa chỉ chi tiết (Giả lập)
            const TextField(
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Địa chỉ chi tiết (Số nhà, Tên đường)',
                prefixIcon: Icon(Icons.location_on_outlined),
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),

            // Nút Lưu thay đổi
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Xử lý logic lưu địa chỉ thực tế và cập nhật lại màn hình Thanh Toán
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Đã cập nhật địa chỉ!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('LƯU THAY ĐỔI', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}