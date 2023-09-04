import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/login_pages.dart';
// ignore: unused_import
import 'package:flutter_application_1/pages/opcoes_pages.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      home: const LoginPage(),
    );
  }
}
