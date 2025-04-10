import 'package:flutter/material.dart';
import 'package:actividad_1/model/carro_model.dart'; // Asegúrate de que el path sea correcto

class DetalleCarroView extends StatefulWidget {
  final Carro carro;

  const DetalleCarroView({Key? key, required this.carro}) : super(key: key);

  @override
  State<DetalleCarroView> createState() => _DetalleCarroViewState();
}

class _DetalleCarroViewState extends State<DetalleCarroView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('¿Desea tomar el carro?', style: TextStyle(fontWeight: FontWeight.bold)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('No'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                
              },
              child: const Text('Sí'),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final carro = widget.carro;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del Carro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (carro.imagen.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  carro.imagen,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              )
            else
              const Icon(Icons.directions_car, size: 100),

            const SizedBox(height: 20),
            Text('Placa: ${carro.placa}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Conductor: ${carro.conductor}', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
