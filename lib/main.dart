import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:actividad_1/view/login_view.dart';
import 'package:actividad_1/view/home_menu_view.dart';

void main() {
  runApp(const CarrosApp());
}

class CarrosApp extends StatelessWidget {
  const CarrosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carros Eléctricos',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: const LoginView(),
    );
  }
}