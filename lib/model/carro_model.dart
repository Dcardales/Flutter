class Carro {
  final String placa;
  final String conductor;
  final String imagen;

  Carro({required this.placa, required this.conductor, required this.imagen});

  factory Carro.fromJson(Map<String, dynamic> json) {
    return Carro(
      placa: json['placa'] ?? 'Sin placa',
      conductor: json['conductor'] ?? 'Sin nombre',
      imagen: json['imagen'] ?? '',
    );
  }
}
