// lib/models/clinica.dart

class Clinica {
  final int id;
  final String nombre;
  final String foto_url;  // Nuevo campo para la URL de la imagen

  // Constructor
  Clinica({
    required this.id,
    required this.nombre,
    required this.foto_url,  // Incluir el campo foto_url en el constructor
  });

  // Método para crear una instancia de Clinica a partir de un mapa JSON
  factory Clinica.fromJson(Map<String, dynamic> json) {
    return Clinica(
      id: json['id'],
      nombre: json['nombre'],
      foto_url: json['foto_url'],  // Asegúrate de que el campo 'foto_url' esté en el JSON de respuesta
    );
  }
}

