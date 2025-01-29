import 'package:flutter/material.dart';
import 'package:store_manager/features/auth/presentation/pages/login_page.dart';
import 'package:store_manager/features/auth/presentation/pages/register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLogin = true;

  void togglePages() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLogin) {
      return LoginPage(togglePages: togglePages);
    } else {
      return RegisterPage(togglePages: togglePages);
    }
  }
}
