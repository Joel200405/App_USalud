import 'package:flutter/material.dart';
import '../styles/colors.dart';

class ClinicsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> clinics = [
      {
        'name': 'Clínica ConfiaSalud',
        'image': 'assets/images/Confia_Salud.jpg',
        'rating': 5,
      },
      {
        'name': 'Clínica Ortega',
        'image': 'assets/images/Ortega.png',
        'rating': 4,
      },
      {
        'name': 'Clínica Zarate',
        'image': 'assets/images/zarate.jpg',
        'rating': 4,
      },
      {
        'name': 'Clínica Rebagliati',
        'image': 'assets/images/rebagliati.jpg',
        'rating': 5,
      },
      {
        'name': 'Clínica Chenet',
        'image': 'assets/images/chenet.jpg',
        'rating': 3,
      },
      {
        'name': 'Santo Domingo',
        'image': 'assets/images/santo.png',
        'rating': 4,
      },
      {
        'name': 'Daniel Alcides Carrión',
        'image': 'assets/images/carrion.jpg',
        'rating': 5,
      },
      {
        'name': 'El Carmen',
        'image': 'assets/images/carmen.jpg',
        'rating': 3,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.primary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Centros de Salud',
          style: TextStyle(
            color: AppColors.primary,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 21
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
              borderRadius:
                  BorderRadius.all(Radius.circular(16.0)), // Bordes redondeados
            ),
            onSelected: (String route) {
              Navigator.pushNamed(context, route);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: '/login',
                child: Row(
                  children: [
                    Icon(Icons.login,
                        color: AppColors.white), // Ícono de inicio de sesión
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
                    Icon(Icons.edit_note, color: AppColors.white),
                    const SizedBox(width: 8),
                    Text(
                      'Agendar cita',
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
            ],
          )
        ],
        backgroundColor: AppColors.accent// Color azul verdoso
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.9999,
          ),
          itemCount: clinics.length,
          itemBuilder: (context, index) {
            return ClinicCard(
              name: clinics[index]['name'],
              imagePath: clinics[index]['image'],
              rating: clinics[index]['rating'],
            );
          },
        ),
      ),
    );
  }
}

class ClinicCard extends StatelessWidget {
  final String name;
  final String imagePath;
  final int rating;

  ClinicCard({required this.name, required this.imagePath, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // Centra el contenido horizontalmente
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
            child: Image.asset(
              imagePath,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    name,
                    style: TextStyle(
                      fontFamily: 'Poppins', // Cambia la fuente a Poppins
                      fontWeight: FontWeight.bold, // Negrita
                      fontSize: 15,
                      color: Colors.black, // Color primario
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Centra las estrellas
                  children: List.generate(5, (index) {
                    return Icon(
                      Icons.star,
                      color: index < rating ? Colors.orange : Colors.grey,
                      size: 16,
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
