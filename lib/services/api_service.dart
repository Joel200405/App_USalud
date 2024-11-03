import 'dart:convert';
import 'category.dart'; // Asegúrate de que la ruta sea correcta
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
    final url = Uri.parse('$baseUrl/auth/guardarUsuario');
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
  Future<Map<String, dynamic>> loginUser({
    required String correo,
    required String contrasena,
  }) async {
    final url = Uri.parse('$baseUrl/auth/login');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'correo': correo,
        'contrasena': contrasena,
      }),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return {
        'error': true,
        'message': 'Error al iniciar sesión. Verifica tus credenciales.',
      };
    }
  }

  // Método para obtener todas las categorías
  Future<List<Category>> fetchCategories() async {
    final url = Uri.parse('$baseUrl/auth/categorias-sintomas');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> categoriasData = json.decode(response.body);
      return categoriasData
          .map<Category>((categoria) => Category(
                id: categoria[
                    'id'], // Asegúrate de que el ID esté en la respuesta
                name: categoria['nombre'].toString(),
              ))
          .toList();
    } else {
      print('Error al cargar categorías: ${response.body}');
      return [];
    }
  }

  // Método para obtener síntomas de una categoría específica
  Future<List<String>> fetchSymptomByCategory(int categoriaId) async {
    final url = Uri.parse('$baseUrl/auth/sintomas/$categoriaId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> sintomasData = json.decode(response.body);
      return sintomasData
          .map<String>((sintoma) => sintoma['nombre'].toString())
          .toList();
    } else {
      // Agregar más detalles al registro de errores
      print(
          'Error al obtener síntomas (Código: ${response.statusCode}): ${response.body}');
      return [];
    }
  }

  // Método para verificar el estado de la sesión
  Future<bool> verificarSesion(String token) async {
    final url = Uri.parse('$baseUrl/auth/estado-sesion');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      print('Error al verificar sesión: ${response.body}');
      return false;
    }
  }

  // Método para buscar síntomas por caracteres ingresados
  Future<List<String>> buscarSintomas(String termino) async {
    final url = Uri.parse('$baseUrl/auth/buscar-sintomas?termino=$termino');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> sintomasData = json.decode(response.body);
      return sintomasData
          .map<String>((sintoma) => sintoma['nombre'].toString())
          .toList();
    } else {
      print('Error al buscar síntomas: ${response.body}');
      return [];
    }
  }

  Future<Map<String, String>> obtenerEnfermedadYRecomendacion({
    required List<int> sintomasSeleccionados,
    required int edad,
    required int diasSintomas,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/obtener-recomendacion'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'sintomasSeleccionados': sintomasSeleccionados,
          'edad': edad,
          'diasSintomas': diasSintomas,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return {
          'enfermedad': data['enfermedad_nombre'],
          'recomendacion': data['recomendacion'],
        };
      } else {
        print("Error en la respuesta: ${response.statusCode}");
        print("Mensaje de error: ${response.body}");
        throw Exception("Error en la solicitud: Código ${response.statusCode}");
      }
    } catch (e) {
      print("Excepción al hacer la solicitud: $e");
      throw Exception("Error al obtener diagnóstico");
    }
  }
 
  // Método para obtener todas las clínicas
  Future<List<dynamic>> fetchClinics() async {
    final url = Uri.parse('$baseUrl/auth/clinicas');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> clinicsData = json.decode(response.body);
      return clinicsData; // Devuelve la lista de clínicas
    } else {
      print('Error al cargar clínicas: ${response.body}');
      return [];
    }
  }

  // Método para obtener todos los servicios
  Future<List<dynamic>> fetchServices() async {
    final url = Uri.parse('$baseUrl/auth/categorias-servicios');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> servicesData = json.decode(response.body);
      return servicesData
      .map<Category>((categoria) => Category(
                id: categoria[
                    'id'], // Asegúrate de que el ID esté en la respuesta
                name: categoria['nombre'].toString(),
              ))
          .toList();
    } else {
      print('Error al cargar servicios: ${response.body}');
      return [];
    }
  }

  // Método para obtener servicios de una categoría específica
  Future<List<String>> fetchServiceByCategory(int categoriaId) async {
    final url = Uri.parse('$baseUrl/auth/servicios/$categoriaId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> serviciosData = json.decode(response.body);
      return serviciosData
          .map<String>((servicio) => servicio['nombre'].toString())
          .toList();
    } else {
      // Agregar más detalles al registro de errores
      print(
          'Error al obtener servicios (Código: ${response.statusCode}): ${response.body}');
      return [];
    }
  }

  // Método para buscar servicios por caracteres ingresados
  Future<List<dynamic>> buscarServicios(String termino) async {
    final url = Uri.parse('$baseUrl/auth/buscar-servicios?termino=$termino');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> servicesData = json.decode(response.body);
      return servicesData
          .map<String>((sintoma) => sintoma['nombre'].toString())
          .toList();
    } else {
      print('Error al buscar servicios: ${response.body}');
      return [];
    }
  }

}
