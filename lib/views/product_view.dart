import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/viewmodels/auth_viewmodel.dart';
import 'package:todo/viewmodels/product_viewmodel.dart';
import 'package:todo/views/login_view.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductViewModel>().fetchProducts();
    });
  }

  Future<void> _handleLogout() async {
    final authVM = context.read<AuthViewModel>();
    await authVM.logout();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginView()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        actions: [
          IconButton(onPressed: _handleLogout, icon: const Icon(Icons.logout)),
        ],
      ),
      body: Consumer<ProductViewModel>(
        builder: (context, productVM, _) {
          if (productVM.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (productVM.errorMessage != null) {
            return Center(child: Text(productVM.errorMessage!));
          }

          return ListView.builder(
            itemCount: productVM.products.length,
            itemBuilder: (context, index) {
              final p = productVM.products[index];
              return ListTile(
                title: Text(p.productName),
                subtitle: Text("${p.mainCategory} / ${p.category}"),
                trailing: Text("₹${p.mrp}"),
              );
            },
          );
        },
      ),
    );
  }
}
