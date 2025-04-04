import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:actividad_1/view/login_view.dart';
import 'package:actividad_1/view/carros_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

  runApp(CarrosApp(isLoggedIn: token != null));
}

class CarrosApp extends StatelessWidget {
  final bool isLoggedIn;

  const CarrosApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carros Eléctricos',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? const CarrosView() : const LoginView(),
    );
  }
}
