import 'package:flutter/material.dart';
import '../styles/colors.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Servicios',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        centerTitle: false,
        backgroundColor: const Color.fromRGBO(110, 244, 220, 1),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () {
            Navigator.pop(context); 
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: AppColors.primary),
            onPressed: () {
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'assets/images/Logo_App.png',
                height: 80,
              ),
              const SizedBox(height: 20),
              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2, // Dos contenedores por fila
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: [
                  _buildServiceButton(
                    context,
                    'Inicio de Sesión',
                    AppColors.secondary,
                    Icons.login,
                    '/login',
                  ),
                  _buildServiceButton(
                    context,
                    'Registro',
                    AppColors.secondary,
                    Icons.person_add,
                    '/register', 
                  ),
                  _buildServiceButton(
                    context,
                    'Recuperación de Contraseña',
                    AppColors.secondary,
                    Icons.lock_reset,
                    '/reset_password',
                  ),
                  _buildServiceButton(
                    context,
                    'Perfil',
                    AppColors.secondary,
                    Icons.person,
                    '/perfil',
                  ),
                  _buildServiceButton(
                    context,
                    'Historial Médico',
                    AppColors.secondary,
                    Icons.history,
                    '/historial_medico',
                  ),
                  _buildServiceButton(
                    context,
                    'Agregar Síntomas',
                    AppColors.secondary,
                    Icons.add_circle,
                    '/agregar_sintomas',
                  ),
                  _buildServiceButton(
                    context,
                    'Predicciones',
                    AppColors.secondary,
                    Icons.trending_up,
                    '/predicciones',
                  ),
                  _buildServiceButton(
                    context,
                    'Control del Ciclo Menstrual',
                    AppColors.secondary,
                    Icons.calendar_today,
                    '/control_ciclo',
                  ),
                  _buildServiceButton(
                    context,
                    'Citas',
                    AppColors.secondary,
                    Icons.event,
                    '/citas',
                  ),
                  _buildServiceButton(
                    context,
                    'Emergencias',
                    AppColors.secondary,
                    Icons.warning,
                    '/emergencias',
                  ),
                  _buildServiceButton(
                    context,
                    'Listado de Clínicas',
                    AppColors.secondary,
                    Icons.local_hospital,
                    '/clinicas',
                  ),
                  _buildServiceButton(
                    context,
                    'Mapa de Emergencia',
                    AppColors.secondary,
                    Icons.map,
                    '/emergencias/mapa',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceButton(BuildContext context, String title, Color color, IconData icon, String route) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route); // Navegar a la pantalla de detalles del servicio
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: AppColors.white,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white, 
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}