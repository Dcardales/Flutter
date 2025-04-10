import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  static Future<bool> login(String username, String password) async {
    return username == 'admin' && password == 'admin';
  }

  static Future<void> logout() async {}
}

