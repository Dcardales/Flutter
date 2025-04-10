import 'package:flutter/material.dart';
import 'package:actividad_1/view/carros_view.dart';
import 'package:actividad_1/view/qr_scanner_view.dart';
import 'package:actividad_1/controller/auth_controller.dart';
import 'package:actividad_1/view/login_view.dart';

class HomeMenuView extends StatelessWidget {
  const HomeMenuView({super.key});

  void _logout(BuildContext context) async {
    await AuthController.logout();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginView()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('Menú Principal'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _MenuCard(
              icon: Icons.directions_car,
              title: 'Ver mis carros',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CarrosView()),
                );
              },
            ),
            const SizedBox(height: 20),
            _MenuCard(
              icon: Icons.qr_code_scanner,
              title: 'Escanear código QR',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const QRScannerView()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _MenuCard({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Colors.blueAccent.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16),
          child: Row(
            children: [
              Icon(icon, size: 40, color: Colors.blueAccent),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}