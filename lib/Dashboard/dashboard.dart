import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/Authchecker/auth_checker.dart';
import '../models/product_model.dart';
import '../services/product_service.dart';
import 'package:todo/Authchecker/auth.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late Future<List<Product>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = ProductService.getProducts();
  }

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove("token");

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),

        // ✅ logout button added here
        actions: [
          IconButton(
            onPressed: () => logout(context),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),

      body: FutureBuilder<List<Product>>(
        future: futureProducts,

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final products = snapshot.data!;

          return ListView.builder(
            itemCount: products.length,

            itemBuilder: (context, index) {
              final p = products[index];

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
