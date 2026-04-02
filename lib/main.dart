import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/viewmodels/auth_viewmodel.dart';
import 'package:todo/viewmodels/product_viewmodel.dart';
import 'package:todo/views/auth_check_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => ProductViewModel()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthCheckView(),
      ),
    );
  }
}
