import 'package:flutter/material.dart';
import 'signup_page.dart';
import 'main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    final String id = _idController.text;
    final String password = _passwordController.text;

    if (id == "admin" && password == "1234") {
      // 로그인 성공 처리
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()),
      );
    }
    else {
      // 로그인 실패 처리
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('로그인 실패')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
        body:Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Column 내용을 중앙에 배치
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  controller: _idController,
                  decoration: const InputDecoration(labelText: 'ID'),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                child: TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
              ),
              ElevatedButton(
                onPressed: _login,
                child: const Text('로그인'),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpPage()),
                  );
                },
                child: const Text('회원가입'),
              ),
            ],
          ),
        ),
    );
  }
}