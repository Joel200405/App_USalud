import 'package:flutter/material.dart';
import 'trapezoid_painter.dart';
import '../styles/colors.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(110, 244, 220, 1),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.primary,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Restablecer contraseña',
          style: TextStyle(
            color: AppColors.primary,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
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
      ),
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // Ocultar el teclado al hacer tap en cualquier lugar
        },
        child: Stack(
          children: [
            // Dibuja el trapezoide en la parte superior
            CustomPaint(
              size: Size(
                MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height * 0.5,
              ),
              painter: TrapezoidPainter(), // Asegúrate de tener TrapezoidPainter importado
            ),
            // Centrar el contenedor de forma dinámica y evitar que se vea afectado por el teclado
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: _buildResetPasswordForm(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResetPasswordForm(BuildContext context) {
    return Container(
      width: 355,
      padding: const EdgeInsets.all(25.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.border, width: 2),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: AppColors.secondary,
            selectionColor: AppColors.secondary.withOpacity(0.3),
            selectionHandleColor: AppColors.secondary,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/Logo_App.png',
              width: 120,
              height: 120,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: const Text(
                "Para restablecer su contraseña:",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            const SizedBox(height: 10),
            _buildEmailField(),
            const SizedBox(height: 20),
            _buildSendButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return TextField(
      decoration: const InputDecoration(
        labelText: 'Correo electrónico o celular',
        labelStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
          color: AppColors.textSecondary,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.secondary),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
      style: const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 16,
        color: AppColors.textPrimary,
      ),
      cursorColor: AppColors.secondary,
    );
  }

  Widget _buildSendButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Mostrar la ventana de notificación al presionar el botón
        _showDialog(context, 'Código enviado', 'Te hemos enviado un código para restablecer tu contraseña.');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
      ),
      child: const Text(
        '                 ENVIAR                 ',
        style: TextStyle(
          color: AppColors.white,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  // Función para mostrar la notificación
  void _showDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.accent,
          contentPadding: const EdgeInsets.all(15.0),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  message,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'ACEPTAR',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
