class Carro {
  final String id;
  final String marca;
  final String modelo;

  Carro({required this.id, required this.marca, required this.modelo});

  factory Carro.fromJson(Map<String, dynamic> json) {
    return Carro(
      id: json['id'].toString(),
      marca: json['marca'] ?? 'Desconocida',
      modelo: json['modelo'] ?? 'Desconocido',
    );
  }
}