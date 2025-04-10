
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:actividad_1/controller/carros_controller.dart';
import 'package:actividad_1/controller/auth_controller.dart';
import 'package:actividad_1/view/login_view.dart';
import 'detalle_carro_view.dart';

class QRScannerView extends StatefulWidget {
  const QRScannerView({super.key});

  @override
  State<QRScannerView> createState() => _QRScannerViewState();
}

class _QRScannerViewState extends State<QRScannerView> {
  bool _isScanning = true;

  void _onDetect(BarcodeCapture capture) async {
    if (!_isScanning) return;

    final barcode = capture.barcodes.first;
    final code = barcode.rawValue;
    if (code == null) return;

    setState(() {
      _isScanning = false;
    });

    try {
      final carro = await CarrosController.obtenerCarroPorQR(code);

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetalleCarroView(carro: carro),
          ),
        ).then((_) => setState(() => _isScanning = true));
      }
    } catch (e) {
      setState(() => _isScanning = true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Carro no encontrado: $code')),
      );
    }
  }

  void _logout() async {
    await AuthController.logout();
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginView()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escanear Código QR'),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          )
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            onDetect: _onDetect,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 40),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Escanea el código QR',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
