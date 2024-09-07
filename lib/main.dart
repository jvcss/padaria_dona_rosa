import 'package:flutter/material.dart';
import 'package:padaria_dona_rosa/bread_making_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BreadMakingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}