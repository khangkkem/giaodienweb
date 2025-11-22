import 'package:flutter/material.dart';
import 'screens/auth_screen.dart'; // Import màn hình AuthScreen đã tạo

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '3T2K Shop',
      theme: ThemeData(
        // Thiết lập màu chủ đạo cho toàn bộ ứng dụng
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // AuthScreen là Widget đầu tiên được hiển thị
      home: const AuthScreen(),
    );
  }
}