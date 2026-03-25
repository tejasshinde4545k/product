import 'package:flutter/material.dart';
import 'package:todo/Authchecker/auth.dart';
import 'package:todo/Authchecker/auth_checker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthCheck(),
    );
  }
}
