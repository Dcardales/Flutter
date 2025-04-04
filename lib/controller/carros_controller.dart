import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:actividad_1/model/carro_model.dart';

class CarrosController {
  static const String _url =
      'https://carros-electricos.wiremockapi.cloud/carros';

  static Future<List<Carro>> obtenerCarros() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) return [];

    final response = await http.get(
      Uri.parse(_url),
      headers: {
        'Authorization': token, 
        'Content-Type': 'application/json',
      },
    );

    print('TOKEN ENVIADO: $token');
    print('STATUS: ${response.statusCode}');
    print('BODY: ${response.body}');

    print('Respuesta carros: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => Carro.fromJson(item)).toList();
    } else {
      print('Error al obtener carros: ${response.statusCode}');
      return [];
    }
  }
}
