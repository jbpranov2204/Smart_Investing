import 'package:flutter/material.dart';
import 'package:smart_investing/LoginPage/login_page.dart';

void main() {
  runApp(const myApp());
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LoginPageWeb(), debugShowCheckedModeBanner: false);
  }
}
