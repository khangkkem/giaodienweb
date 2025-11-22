import 'package:flutter/material.dart';
import 'login_page.dart';
import 'register_page.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // Biến trạng thái để xác định hiển thị màn hình nào
  bool showLoginPage = true;

  // Hàm được truyền vào các màn hình con để chuyển đổi trạng thái
  void toggleView() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      // Hiển thị LoginPage, truyền hàm chuyển đổi
      return LoginPage(toggleView: toggleView);
    } else {
      // Hiển thị RegisterPage, truyền hàm chuyển đổi
      return RegisterPage(toggleView: toggleView);
    }
  }
}