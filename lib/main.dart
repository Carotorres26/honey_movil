import 'package:flutter/material.dart';
import 'package:h_honey/pages/login_page.dart';
import 'package:h_honey/pages/menu_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login H_Honey',
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/menu': (context) => const MenuPage(),
      },
    );
  }
}
