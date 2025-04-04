import 'package:actividad_1/controller/auth_controller.dart';
import 'package:actividad_1/view/carros_view.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  void _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final success = await AuthController.login(
      _usernameController.text,
      _passwordController.text,
    );

    setState(() {
      _isLoading = false;
    });

    if (success) {
      // 🚀 Navega directamente a la vista de carros
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const CarrosView()),
      );
    } else {
      setState(() {
        _errorMessage = 'Usuario o contraseña incorrectos';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Iniciar Sesión')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Usuario'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            if (_isLoading) const CircularProgressIndicator(),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _isLoading ? null : _login,
              child: const Text('Ingresar'),
            ),
          ],
        ),
      ),
    );
  }
}
