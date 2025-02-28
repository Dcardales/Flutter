import 'package:flutter/material.dart';
import '../widgets/vehicle_card.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Usuario: Pepe Perez"),
        backgroundColor: const Color.fromARGB(255, 31, 33, 124),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {},
              child: Text("Inicio"),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return VehicleCard();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}