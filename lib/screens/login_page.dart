import 'package:flutter/material.dart';
// Import màn hình Trang chủ để điều hướng tới sau khi đăng nhập thành công
import 'home_screen.dart';

class LoginPage extends StatefulWidget {
  // Nhận hàm chuyển đổi từ AuthScreen để chuyển sang Đăng ký
  final Function toggleView;
  const LoginPage({super.key, required this.toggleView});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Khai báo GlobalKey để quản lý Form
  final _formKey = GlobalKey<FormState>();
  // Khai báo các Controller để lấy dữ liệu từ TextFormField
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // Rất quan trọng: giải phóng controller để tránh rò rỉ bộ nhớ
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Hàm xử lý khi người dùng nhấn nút Đăng nhập
  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      // TODO: 1. THỰC HIỆN LOGIC ĐĂNG NHẬP THỰC TẾ (Gọi API, Firebase,...)

      // Giả định quá trình đăng nhập thành công:
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đăng nhập thành công! Chuyển trang...')),
      );

      // 2. Điều hướng đến HomeScreen
      // pushReplacement ngăn người dùng nhấn nút Back để quay lại màn hình Login
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Logo/Tên shop
                const Text(
                  'Your Fashion Shop',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                ),
                const SizedBox(height: 40),

                // Tiêu đề
                const Text(
                  'Đăng nhập',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                const SizedBox(height: 30),

                // Trường Email
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  validator: (val) => val!.isEmpty ? 'Email không được để trống' : null,
                ),
                const SizedBox(height: 20),

                // Trường Mật khẩu
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Mật khẩu',
                    prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  validator: (val) => val!.length < 6 ? 'Mật khẩu phải có ít nhất 6 ký tự' : null,
                ),
                const SizedBox(height: 30),

                // Nút Đăng nhập
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: _handleLogin, // Gọi hàm xử lý đã định nghĩa ở trên
                    child: const Text(
                      'Đăng nhập',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Nút Chuyển sang Đăng ký
                TextButton(
                  onPressed: () {
                    widget.toggleView(); // Gọi hàm chuyển đổi từ AuthScreen
                  },
                  child: const Text(
                    'Chưa có tài khoản? Đăng ký ngay!',
                    style: TextStyle(color: Colors.deepPurple),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}