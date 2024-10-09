import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://192.168.1.20:3000';
  
  // Método para registrar un usuario
  Future<bool> registerUser({
    required String nombre,
    required String apellidoPaterno,
    required String apellidoMaterno,
    required String correo,
    required String contrasena,
    required String telefono,
  }) async {
    final url = Uri.parse('$baseUrl/api/guardarUsuario');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'nombre': nombre,
        'apellido_paterno': apellidoPaterno,
        'apellido_materno': apellidoMaterno,
        'correo': correo,
        'contrasena': contrasena,
        'telefono': telefono,
      }),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      print('Error al registrar usuario: ${response.body}');
      return false;
    }
  }

  // Método para iniciar sesión
  Future<Map<String, dynamic>> loginUser({required String correo, required String contrasena}) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'correo': correo,
        'contrasena': contrasena,
      }),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      try {
        return json.decode(response.body);
      } catch (e) {
        return {
          'error': false,
          'message': response.body,
        };
      }
    } else {
      return {
        'error': true,
        'message': 'Error al iniciar sesión. Verifica tus credenciales.',
      };
    }
  }

}