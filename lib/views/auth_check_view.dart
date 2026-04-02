import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/viewmodels/auth_viewmodel.dart';
import 'package:todo/views/login_view.dart';
import 'package:todo/views/product_view.dart';

class AuthCheckView extends StatefulWidget {
  const AuthCheckView({super.key});

  @override
  State<AuthCheckView> createState() => _AuthCheckViewState();
}

class _AuthCheckViewState extends State<AuthCheckView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAuth();
    });
  }

  Future<void> _checkAuth() async {
    final authVM = context.read<AuthViewModel>();
    await authVM.checkAuth();

    if (!mounted) return;

    if (authVM.isLoggedIn == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ProductView()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
