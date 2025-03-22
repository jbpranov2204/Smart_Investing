import 'package:flutter/material.dart';
import 'package:smart_investing/HomePage/home_page.dart';
import 'package:smart_investing/HomePage/settings_page.dart';
import 'package:smart_investing/HomePage/stock_page.dart';

void main() {
  runApp(const myApp());
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
