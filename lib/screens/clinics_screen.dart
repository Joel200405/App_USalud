import 'package:flutter/material.dart';
import '../styles/colors.dart'; // Asegúrate de tener esta ruta correcta
import '../services/api_service.dart'; // Asegúrate de que esta ruta sea correcta

class ClinicsScreen extends StatefulWidget {
  const ClinicsScreen({super.key});

  @override
  _ClinicsScreenState createState() => _ClinicsScreenState();
}

class _ClinicsScreenState extends State<ClinicsScreen> {
  List<dynamic> _clinics = [];
  final ApiService _apiService = ApiService(); // Instancia del ApiService

  @override
  void initState() {
    super.initState();
    _fetchClinics(); // Llama al método para obtener clínicas
  }

  Future<void> _fetchClinics() async {
    final clinics = await _apiService.fetchClinics(); // Llama al nuevo método
    setState(() {
      _clinics = clinics; // Actualiza el estado con las clínicas obtenidas
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.primary, // Cambia el color del icono de retroceder
          ),
          onPressed: () {
            Navigator.of(context).pop(); // Vuelve a la pantalla anterior
          },
        ),
        title: const Text(
          'Listado de Centros de Salud',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(
              Icons.menu,
              color: AppColors.primary,
            ),
            color: AppColors.primary, // Color de fondo del menú desplegable
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)), // Bordes redondeados
            ),
            onSelected: (String route) {
              Navigator.pushNamed(context, route);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: '/login',
                child: Row(
                  children: [
                    Icon(Icons.login, color: AppColors.white), // Ícono de inicio de sesión
                    const SizedBox(width: 8), // Espacio entre ícono y texto
                    Text(
                      'Inicio de Sesión',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: '/register',
                child: Row(
                  children: [
                    Icon(Icons.person_add, color: AppColors.white),
                    const SizedBox(width: 8),
                    Text(
                      'Registro',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: '/reset_password',
                child: Row(
                  children: [
                    Icon(Icons.lock_reset, color: AppColors.white),
                    const SizedBox(width: 8),
                    Text(
                      'Recuperar Contraseña',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: '/symptoms',
                child: Row(
                  children: [
                    Icon(Icons.add_circle, color: AppColors.white),
                    const SizedBox(width: 8),
                    Text(
                      'Agregar Síntomas',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: '/clinics',
                child: Row(
                  children: [
                    Icon(Icons.local_hospital, color: AppColors.white),
                    const SizedBox(width: 8),
                    Text(
                      'Listado de Clínicas',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: '/meeting',
                child: Row(
                  children: [
                    Icon(Icons.event, color: AppColors.white),
                    const SizedBox(width: 8),
                    Text(
                      'Citas',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: '/emergencias',
                child: Row(
                  children: [
                    Icon(Icons.check, color: AppColors.white),
                    const SizedBox(width: 8),
                    Text(
                      'Sugerencias',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: '/perfil',
                child: Row(
                  children: [
                    Icon(Icons.info, color: AppColors.white),
                    const SizedBox(width: 8),
                    Text(
                      'Información',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
        backgroundColor: const Color.fromRGBO(110, 244, 220, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _clinics.isEmpty 
            ? Center(child: CircularProgressIndicator()) // Muestra un loader mientras se cargan las clínicas
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Dos contenedores por fila
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                itemCount: _clinics.length,
                itemBuilder: (context, index) {
                  return _buildClinicButton(context, _clinics[index]);
                },
              ),
      ),
    );
  }

  Widget _buildClinicButton(BuildContext context, dynamic clinic) {
    // Convertir la calificación a double para evitar errores de tipo
    double calificacion = (clinic['calificacion'] as num).toDouble();

    return GestureDetector(
      onTap: () {
        // Aquí puedes manejar la navegación a la pantalla de detalles de la clínica
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white, // Fondo blanco para el marco
          boxShadow: [
            BoxShadow(
              color: Colors.black26, // Color de la sombra
              blurRadius: 8, // Desenfoque de la sombra
              spreadRadius: 1, // Expansión de la sombra
              offset: Offset(0, 4), // Desplazamiento de la sombra
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias, // Esta propiedad asegura que el contenido no sobresalga
        child: Stack(
          children: [
            // Widget para mostrar la imagen de fondo
            Image.asset(
              clinic['foto_url'], // Usa foto_url que contiene la ruta de la imagen
              fit: BoxFit.cover, // Ajusta cómo se adapta la imagen
              width: double.infinity, // Ocupa todo el ancho del contenedor
              height: 140, // Ajusta la altura según sea necesario
            ),
            // Widget para el contenido (nombre y calificación) encima de la imagen
            Container(
              padding: const EdgeInsets.all(8.0), // Espaciado interno
              alignment: Alignment.bottomCenter, // Alinea el contenido en la parte inferior central
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end, // Alinea el contenido en la parte inferior
                crossAxisAlignment: CrossAxisAlignment.center, // Alinea el contenido horizontalmente en el centro
                children: [
                  Text(
                    clinic['nombre'], // Nombre de la clínica
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4), // Espacio entre nombre y calificación
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildStarRating(calificacion),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método para construir las estrellas basado en la calificación
  List<Widget> _buildStarRating(double rating) {
    List<Widget> stars = [];
    for (int i = 1; i <= 5; i++) {
      if (i <= rating) {
        // Estrella llena
        stars.add(const Icon(
          Icons.star,
          color: Color.fromRGBO(250, 142, 4, 1),
          size: 20,
        ));
      } else if (i - rating < 1) {
        // Media estrella
        stars.add(const Icon(
          Icons.star_half,
          color: Color.fromRGBO(250, 142, 4, 1),
          size: 20,
        ));
      } else {
        // Estrella vacía
        stars.add(const Icon(
          Icons.star_border,
          color: Color.fromRGBO(250, 142, 4, 1),
          size: 20,
        ));
      }
    }
    return stars;
  }
}