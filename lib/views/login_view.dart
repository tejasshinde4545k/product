import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/viewmodels/auth_viewmodel.dart';
import 'package:todo/views/product_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _mobileController = TextEditingController();
  final _pinController = TextEditingController();

  @override
  void dispose() {
    _mobileController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final authVM = context.read<AuthViewModel>();

    final success = await authVM.login(
      _mobileController.text,
      _pinController.text,
    );

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Login Success")));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ProductView()),
      );
    } else if (authVM.errorMessage != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(authVM.errorMessage!)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Consumer<AuthViewModel>(
          builder: (context, authVM, _) {
            return Column(
              children: [
                TextField(
                  controller: _mobileController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: "Mobile Number",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _pinController,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Login PIN",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: authVM.isLoading ? null : _handleLogin,
                    child: authVM.isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Login"),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
