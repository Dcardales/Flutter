
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:actividad_1/model/carro_model.dart';
import 'package:actividad_1/view/home_menu_view.dart';

class QRScannerView extends StatefulWidget {
  const QRScannerView({Key? key}) : super(key: key);

  @override
  State<QRScannerView> createState() => _QRScannerViewState();
}

class _QRScannerViewState extends State<QRScannerView> {
  bool _scanned = false;
  bool _notificandoError = false;
  List<Carro> listaDeCarros = [];
  Carro? carroDetectado;

  @override
  void initState() {
    super.initState();
    _cargarCarros();
  }

  Future<void> _cargarCarros() async {
    try {
      final response = await http.get(Uri.parse('https://67f7d1812466325443eadd17.mockapi.io/carros'));
      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        setState(() {
          listaDeCarros = data.map((e) => Carro.fromJson(e)).toList();
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al obtener carros: \$e')),
      );
    }
  }

  void _onDetect(BarcodeCapture barcode) {
  if (_scanned || listaDeCarros.isEmpty) return;

  final code = barcode.barcodes.first.rawValue;
  if (code == null || code.isEmpty) return;

  Carro? carro;
  try {
    carro = listaDeCarros.firstWhere(
      (c) => c.placa.toLowerCase() == code.toLowerCase(),
    );
  } catch (_) {
    carro = null;
  }

  if (carro != null) {
    setState(() {
      _scanned = true;
      carroDetectado = carro;
      _notificandoError = false;
    });
  } else if (!_notificandoError) {
    _notificandoError = true;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Carro no encontrado')),
    );

    Future.delayed(const Duration(seconds: 1), () {
      _notificandoError = false;
    });
  }
}

  void _reiniciarEscaneo() {
    setState(() {
      _scanned = false;
      carroDetectado = null;
    });
  }

  void _irAlMenu() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const HomeMenuView()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text('Escáner QR')),
      body: Stack(
        children: [
          if (!_scanned)
            MobileScanner(
              onDetect: _onDetect,
            ),
          if (!_scanned)
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black87, Colors.transparent, Colors.black87],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          if (!_scanned)
            Center(
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 3),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          if (_scanned && carroDetectado != null)
            Container(
              color: Colors.black.withOpacity(0.9),
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (carroDetectado!.imagen.isNotEmpty)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        carroDetectado!.imagen,
                        height: 150,
                      ),
                    ),
                  const SizedBox(height: 20),
                  Text(
                    'Placa: ${carroDetectado!.placa}',
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  Text(
                    'Conductor: ${carroDetectado!.conductor}',
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    '¿Deseas buscar otro vehículo?',
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _reiniciarEscaneo,
                        child: const Text('Sí'),
                      ),
                      const SizedBox(width: 20),
                      OutlinedButton(
                        onPressed: _irAlMenu,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Colors.white),
                        ),
                        child: const Text('No'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
