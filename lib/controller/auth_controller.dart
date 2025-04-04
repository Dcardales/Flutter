import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  static const String _authUrl =
      'https://carros-electricos.wiremockapi.cloud/auth';

  static Future<bool> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse(_authUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      print('Respuesta completa: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];

        if (token != null && token.isNotEmpty) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);
          print('Token guardado: $token');
          return true;
        } else {
          print('Token vacío o no encontrado');
          return false;
        }
      } else {
        print('Error en login: código ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Excepción durante login: $e');
      return false;
    }
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}
