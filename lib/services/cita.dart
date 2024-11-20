// clinica.dart
class Cita {
  final int id;
  final String servicio;
  final String clinica;
  final int documento;
  final String motivo;
  final String fecha;
  final String hora;

  Cita({required this.id, required this.servicio, required this.clinica, required this.documento, required this.motivo, required this.fecha, required this.hora});

  // Método para crear una instancia de Clinica a partir de un mapa JSON
  factory Cita.fromJson(Map<String, dynamic> json) {
    return Cita(
      id: json['id'],
      servicio: json['servicio'],
      clinica: json['clinica'],
      documento: json['documento'],
      motivo: json['motivo'],
      fecha: json['fecha'],
      hora: json['hora'],
    );
  }
}