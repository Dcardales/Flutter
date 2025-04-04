import 'dart:convert';
import 'package:actividad_1/model/carro_model.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class CarrosController {
  static const String _url = 'https://carros-electricos.wiremockapi.cloud/carros';

  static Future<List<Carro>> obtenerCarros() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) return [];

    final response = await http.get(
      Uri.parse(_url),
      headers: {'Authentication': token},
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((carro) => Carro.fromJson(carro)).toList();
    } else {
      return [];
    }
  }
}