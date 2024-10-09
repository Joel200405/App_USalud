import 'package:flutter/material.dart';
import 'trapezoid_painter.dart';
import '../services/api_service.dart'; // Asegúrate de incluir el ApiService si lo necesitas
import '../styles/colors.dart'; // Asegúrate de incluir los colores

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
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
          IconButton(
            icon: const Icon(
              Icons.menu,
              color: AppColors.primary,
            ),
            onPressed: () {},
          ),
        ],
      ),
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomPaint(
                size: Size(
                  MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height * 0.55,
                ),
                painter: TrapezoidPainter(), // Asegúrate de tener TrapezoidPainter importado
              ),
            ),
            // Ajustar el contenedor para estar centrado
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
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
