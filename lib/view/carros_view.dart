import 'package:actividad_1/controller/carros_controller.dart';
import 'package:actividad_1/controller/auth_controller.dart';
import 'package:actividad_1/model/carro_model.dart';
import 'package:actividad_1/view/login_view.dart';
import 'package:flutter/material.dart';

class CarrosView extends StatefulWidget {
  const CarrosView({super.key});

  @override
  State<CarrosView> createState() => _CarrosViewState();
}

class _CarrosViewState extends State<CarrosView> {
  late Future<List<Carro>> _carros;

  @override
  void initState() {
    super.initState();
    _carros = CarrosController.obtenerCarros();
  }

  void _logout() async {
    await AuthController.logout();
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Carros Eléctricos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          )
        ],
      ),
      body: FutureBuilder<List<Carro>>(
        future: _carros,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar los carros.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No tienes carros asociados.'));
          } else {
            final carros = snapshot.data!;
            return ListView.builder(
              itemCount: carros.length,
              itemBuilder: (context, index) {
                final carro = carros[index];
                return ListTile(
                  leading: const Icon(Icons.electric_car),
                  title: Text('${carro.marca} ${carro.modelo}'),
                  subtitle: Text('ID: ${carro.id}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
