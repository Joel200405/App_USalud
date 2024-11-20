// clinica.dart
class Clinica {
  final int id;
  final String nombre;

  Clinica({required this.id, required this.nombre});

  // Método para crear una instancia de Clinica a partir de un mapa JSON
  factory Clinica.fromJson(Map<String, dynamic> json) {
    return Clinica(
      id: json['id'],
      nombre: json['nombre'],
    );
  }
}
